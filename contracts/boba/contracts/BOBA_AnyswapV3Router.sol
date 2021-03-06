// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.7.6;

import "./BOBA_LibTransferHelper.sol";
import "./BOBA_LibSafeMathSushiswap.sol";

interface AnyswapV1ERC20 {
    function mint(address to, uint256 amount) external returns (bool);

    function burn(address from, uint256 amount) external returns (bool);

    function changeVault(address newVault) external returns (bool);

    function depositVault(uint256 amount, address to)
        external
        returns (uint256);

    function withdrawVault(
        address from,
        uint256 amount,
        address to
    ) external returns (uint256);

    function underlying() external view returns (address);
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function permit(
        address target,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function transferWithPermit(
        address target,
        address to,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface ISushiswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

library Address {
    function isContract(address account) internal view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != 0x0 && codehash != accountHash);
    }
}

library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function callOptionalReturn(IERC20 token, bytes memory data) private {
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

interface ISushiswapV2Proxy {
    function factory() external view returns (address);

    function sortTokens(address tokenA, address tokenB)
        external
        pure
        returns (address token0, address token1);

    function pairFor(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function getReserves(address tokenA, address tokenB)
        external
        view
        returns (uint256 reserveA, uint256 reserveB);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] memory path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] memory path)
        external
        view
        returns (uint256[] memory amounts);

    function swap(
        uint256[] memory amounts,
        address[] memory path,
        address _to
    ) external;
}

interface IwNATIVE {
    function deposit() external payable;

    function transfer(address to, uint256 value) external returns (bool);

    function withdraw(uint256) external;
}

contract AdminManagable {
    bool public underAdmin = false;
    address public admin;

    modifier onlyAdmin() {
        require(isAdmin());
        _;
    }

    function isAdmin() internal view returns (bool) {
        return (underAdmin == true && msg.sender == admin);
    }

    function allowAdmin(address _admin) internal {
        admin = _admin;
        underAdmin = true;
        emit LogAllowAdmin(admin);
    }

    function forbidAdmin() external onlyAdmin {
        underAdmin = false;
        emit LogForbitAdmin();
    }

    event LogAllowAdmin(address indexed admin);
    event LogForbitAdmin();
}

contract MPCManagable is AdminManagable {
    address private _oldMPC;
    address private _newMPC;
    uint256 private _newMPCEffectiveTime;

    event LogInitMPC(address indexed factory, uint256 chainID);
    event LogChangeMPC(
        address indexed oldMPC,
        address indexed newMPC,
        uint256 indexed effectiveTime,
        uint256 chainID
    );

    function initialMPC(address _mpc) public onlyAdmin returns (bool) {
        require(mpc() == address(0), "AnyswapV3Router: FORBIDDEN");
        require(_mpc != address(0), "AnyswapV3Router: address(0x0)");
        _newMPC = _mpc;
        _newMPCEffectiveTime = block.timestamp;
        emit LogInitMPC(mpc(), cID());
        return true;
    }

    modifier onlyMPC() {
        require(isAdmin() || msg.sender == mpc(), "AnyswapV3Router: FORBIDDEN");
        _;
    }

    function mpc() public view returns (address) {
        if (block.timestamp >= _newMPCEffectiveTime) {
            return _newMPC;
        }
        return _oldMPC;
    }

    function changeMPCInstantly(address newMPC)
        public
        onlyAdmin
        returns (bool)
    {
        require(newMPC != address(0), "AnyswapV3Router: address(0x0)");
        _oldMPC = mpc();
        _newMPC = newMPC;
        _newMPCEffectiveTime = block.timestamp;
        emit LogChangeMPC(_oldMPC, _newMPC, _newMPCEffectiveTime, cID());
        return true;
    }

    function changeMPC(address newMPC) public onlyMPC returns (bool) {
        require(newMPC != address(0), "AnyswapV3Router: address(0x0)");
        _oldMPC = mpc();
        _newMPC = newMPC;
        _newMPCEffectiveTime = block.timestamp + 2 * 24 * 3600;
        emit LogChangeMPC(_oldMPC, _newMPC, _newMPCEffectiveTime, cID());
        return true;
    }

    function cID() public pure returns (uint256 id) {
        assembly {
            id := chainid()
        }
    }
}

contract AnyswapV3Router is MPCManagable {
    using SafeERC20 for IERC20;
    using SafeMathSushiswap for uint256;

    address public wNATIVE = 0x4200000000000000000000000000000000000006;

    address private sushiProxy;

    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, "AnyswapV3Router: EXPIRED");
        _;
    }

    receive() external payable {
        assert(msg.sender == wNATIVE); // only accept Native via fallback from the wNative contract
    }

    /*constructor(
        address _mpc,
        address _sushiproxy
    ) {
        allowAdmin(msg.sender);
        if (_mpc != address(0)) {
            initialMPC(_mpc);
        }
        if (_sushiproxy != address(0)) {
            setSushiProxy(_sushiproxy);
        }
    }*/
    constructor() {
        allowAdmin(msg.sender);
    }

    function setSushiProxy(address _sushiproxy) public onlyMPC returns (bool) {
        sushiProxy = _sushiproxy;
        emit LogSetSushiProxy(sushiProxy, cID());
        return true;
    }

    address private _oldMPC;
    address private _newMPC;
    uint256 private _newMPCEffectiveTime;

    event LogSetSushiProxy(address indexed factory, uint256 chainID);
    event LogChangeRouter(
        address indexed oldRouter,
        address indexed newRouter,
        uint256 chainID
    );
    event LogAnySwapIn(
        bytes32 indexed txhash,
        address indexed token,
        address indexed to,
        uint256 amount,
        uint256 fromChainID,
        uint256 toChainID
    );
    event LogAnySwapOut(
        address indexed token,
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 fromChainID,
        uint256 toChainID
    );
    event LogAnySwapTradeTokensForTokens(
        address[] path,
        address indexed from,
        address indexed to,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 fromChainID,
        uint256 toChainID
    );
    event LogAnySwapTradeTokensForNative(
        address[] path,
        address indexed from,
        address indexed to,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 fromChainID,
        uint256 toChainID
    );

    function changeVault(address token, address newVault)
        public
        onlyMPC
        returns (bool)
    {
        require(newVault != address(0), "AnyswapV3Router: address(0x0)");
        return AnyswapV1ERC20(token).changeVault(newVault);
    }

    function _anySwapOut(
        address from,
        address token,
        address to,
        uint256 amount,
        uint256 toChainID
    ) internal {
        AnyswapV1ERC20(token).burn(from, amount);
        emit LogAnySwapOut(token, from, to, amount, cID(), toChainID);
    }

    // Swaps `amount` `token` from this chain to `toChainID` chain with recipient `to`
    function anySwapOut(
        address token,
        address to,
        uint256 amount,
        uint256 toChainID
    ) external {
        _anySwapOut(msg.sender, token, to, amount, toChainID);
    }

    // Swaps `amount` `token` from this chain to `toChainID` chain with recipient `to` by minting with `underlying`
    function anySwapOutUnderlying(
        address token,
        address to,
        uint256 amount,
        uint256 toChainID
    ) external {
        IERC20(AnyswapV1ERC20(token).underlying()).safeTransferFrom(
            msg.sender,
            token,
            amount
        );
        AnyswapV1ERC20(token).depositVault(amount, msg.sender);
        _anySwapOut(msg.sender, token, to, amount, toChainID);
    }

    function anySwapOutNative(
        address token,
        address to,
        uint256 toChainID
    ) external payable {
        require(
            AnyswapV1ERC20(token).underlying() == wNATIVE,
            "AnyswapV3Router: underlying is not wNATIVE"
        );
        IERC20(wNATIVE).safeTransferFrom(msg.sender, token, msg.value);
        AnyswapV1ERC20(token).depositVault(msg.value, msg.sender);
        _anySwapOut(msg.sender, token, to, msg.value, toChainID);
    }

    function anySwapOutUnderlyingWithPermit(
        address from,
        address token,
        address to,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external {
        address _underlying = AnyswapV1ERC20(token).underlying();
        IERC20(_underlying).permit(
            from,
            address(this),
            amount,
            deadline,
            v,
            r,
            s
        );
        IERC20(_underlying).safeTransferFrom(from, token, amount);
        AnyswapV1ERC20(token).depositVault(amount, from);
        _anySwapOut(from, token, to, amount, toChainID);
    }

    function anySwapOutUnderlyingWithTransferPermit(
        address from,
        address token,
        address to,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external {
        IERC20(AnyswapV1ERC20(token).underlying()).transferWithPermit(
            from,
            token,
            amount,
            deadline,
            v,
            r,
            s
        );
        AnyswapV1ERC20(token).depositVault(amount, from);
        _anySwapOut(from, token, to, amount, toChainID);
    }

    /*
    function anySwapOut(
        address[] calldata tokens,
        address[] calldata to,
        uint256[] calldata amounts,
        uint256[] calldata toChainIDs
    ) external {
        for (uint256 i = 0; i < tokens.length; i++) {
            _anySwapOut(
                msg.sender,
                tokens[i],
                to[i],
                amounts[i],
                toChainIDs[i]
            );
        }
    }
    */

    // swaps `amount` `token` in `fromChainID` to `to` on this chainID
    function _anySwapIn(
        bytes32 txs,
        address token,
        address to,
        uint256 amount,
        uint256 fromChainID
    ) internal {
        AnyswapV1ERC20(token).mint(to, amount);
        emit LogAnySwapIn(txs, token, to, amount, fromChainID, cID());
    }

    // swaps `amount` `token` in `fromChainID` to `to` on this chainID
    // triggered by `anySwapOut`
    function anySwapIn(
        bytes32 txs,
        address token,
        address to,
        uint256 amount,
        uint256 fromChainID
    ) external onlyMPC {
        _anySwapIn(txs, token, to, amount, fromChainID);
    }

    // swaps `amount` `token` in `fromChainID` to `to` on this chainID with `to` receiving `underlying`
    function anySwapInUnderlying(
        bytes32 txs,
        address token,
        address to,
        uint256 amount,
        uint256 fromChainID
    ) external onlyMPC {
        _anySwapIn(txs, token, to, amount, fromChainID);
        AnyswapV1ERC20(token).withdrawVault(to, amount, to);
    }

    // swaps `amount` `token` in `fromChainID` to `to` on this chainID with `to` receiving `underlying` if possible
    function anySwapInAuto(
        bytes32 txs,
        address token,
        address to,
        uint256 amount,
        uint256 fromChainID
    ) external onlyMPC {
        _anySwapIn(txs, token, to, amount, fromChainID);
        AnyswapV1ERC20 _anyToken = AnyswapV1ERC20(token);
        address _underlying = _anyToken.underlying();
        if (
            _underlying != address(0) &&
            IERC20(_underlying).balanceOf(token) >= amount
        ) {
            if (_underlying == wNATIVE) {
                _anyToken.withdrawVault(to, amount, address(this));
                TransferHelper.safeTransfer(wNATIVE, to, amount);
            } else {
                _anyToken.withdrawVault(to, amount, to);
            }
        }
    }

    function depositNative(address token, address to)
        external
        payable
        returns (uint256)
    {
        require(
            AnyswapV1ERC20(token).underlying() == wNATIVE,
            "AnyswapV3Router: underlying is not wNATIVE"
        );
        IwNATIVE(wNATIVE).deposit{value: msg.value}();
        assert(IwNATIVE(wNATIVE).transfer(token, msg.value));
        AnyswapV1ERC20(token).depositVault(msg.value, to);
        return msg.value;
    }

    function withdrawNative(
        address token,
        uint256 amount,
        address to
    ) external returns (uint256) {
        require(
            AnyswapV1ERC20(token).underlying() == wNATIVE,
            "AnyswapV3Router: underlying is not wNATIVE"
        );
        AnyswapV1ERC20(token).withdrawVault(msg.sender, amount, address(this));
        IwNATIVE(wNATIVE).withdraw(amount);
        TransferHelper.safeTransferNative(to, amount);
        return amount;
    }

    // extracts mpc fee from bridge fees
    function anySwapFeeTo(address token, uint256 amount) external onlyMPC {
        address _mpc = mpc();
        AnyswapV1ERC20(token).mint(_mpc, amount);
        AnyswapV1ERC20(token).withdrawVault(_mpc, amount, _mpc);
    }

    /*
    function anySwapIn(
        bytes32[] calldata txs,
        address[] calldata tokens,
        address[] calldata to,
        uint256[] calldata amounts,
        uint256[] calldata fromChainIDs
    ) external onlyMPC {
        for (uint256 i = 0; i < tokens.length; i++) {
            _anySwapIn(txs[i], tokens[i], to[i], amounts[i], fromChainIDs[i]);
        }
    }
    */

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        AnyswapV1ERC20(path[0]).burn(msg.sender, amountIn);
        emit LogAnySwapTradeTokensForTokens(
            path,
            msg.sender,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForTokensUnderlying(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        IERC20(AnyswapV1ERC20(path[0]).underlying()).safeTransferFrom(
            msg.sender,
            path[0],
            amountIn
        );
        AnyswapV1ERC20(path[0]).depositVault(amountIn, msg.sender);
        AnyswapV1ERC20(path[0]).burn(msg.sender, amountIn);
        emit LogAnySwapTradeTokensForTokens(
            path,
            msg.sender,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForTokensUnderlyingWithPermit(
        address from,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        address _underlying = AnyswapV1ERC20(path[0]).underlying();
        IERC20(_underlying).permit(
            from,
            address(this),
            amountIn,
            deadline,
            v,
            r,
            s
        );
        IERC20(_underlying).safeTransferFrom(from, path[0], amountIn);
        AnyswapV1ERC20(path[0]).depositVault(amountIn, from);
        AnyswapV1ERC20(path[0]).burn(from, amountIn);
        {
            address[] memory _path = path;
            address _from = from;
            address _to = to;
            uint256 _amountIn = amountIn;
            uint256 _amountOutMin = amountOutMin;
            uint256 _cID = cID();
            uint256 _toChainID = toChainID;
            emit LogAnySwapTradeTokensForTokens(
                _path,
                _from,
                _to,
                _amountIn,
                _amountOutMin,
                _cID,
                _toChainID
            );
        }
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForTokensUnderlyingWithTransferPermit(
        address from,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        IERC20(AnyswapV1ERC20(path[0]).underlying()).transferWithPermit(
            from,
            path[0],
            amountIn,
            deadline,
            v,
            r,
            s
        );
        AnyswapV1ERC20(path[0]).depositVault(amountIn, from);
        AnyswapV1ERC20(path[0]).burn(from, amountIn);
        emit LogAnySwapTradeTokensForTokens(
            path,
            from,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // Swaps `amounts[path.length-1]` `path[path.length-1]` to `to` on this chain
    // Triggered by `anySwapOutExactTokensForTokens`
    function anySwapInExactTokensForTokens(
        bytes32 txs,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 fromChainID
    )
        external
        virtual
        onlyMPC
        ensure(deadline)
        returns (uint256[] memory amounts)
    {
        amounts = ISushiswapV2Proxy(sushiProxy).getAmountsOut(amountIn, path);
        require(
            amounts[amounts.length - 1] >= amountOutMin,
            "SushiswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT"
        );
        _anySwapIn(
            txs,
            path[0],
            ISushiswapV2Proxy(sushiProxy).pairFor(path[0], path[1]),
            amounts[0],
            fromChainID
        );
        _swap(amounts, path, to);
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForNative(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        AnyswapV1ERC20(path[0]).burn(msg.sender, amountIn);
        emit LogAnySwapTradeTokensForNative(
            path,
            msg.sender,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForNativeUnderlying(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        IERC20(AnyswapV1ERC20(path[0]).underlying()).safeTransferFrom(
            msg.sender,
            path[0],
            amountIn
        );
        AnyswapV1ERC20(path[0]).depositVault(amountIn, msg.sender);
        AnyswapV1ERC20(path[0]).burn(msg.sender, amountIn);
        emit LogAnySwapTradeTokensForNative(
            path,
            msg.sender,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForNativeUnderlyingWithPermit(
        address from,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        address _underlying = AnyswapV1ERC20(path[0]).underlying();
        IERC20(_underlying).permit(
            from,
            address(this),
            amountIn,
            deadline,
            v,
            r,
            s
        );
        IERC20(_underlying).safeTransferFrom(from, path[0], amountIn);
        AnyswapV1ERC20(path[0]).depositVault(amountIn, from);
        AnyswapV1ERC20(path[0]).burn(from, amountIn);
        {
            address[] memory _path = path;
            address _from = from;
            address _to = to;
            uint256 _amountIn = amountIn;
            uint256 _amountOutMin = amountOutMin;
            uint256 _cID = cID();
            uint256 _toChainID = toChainID;
            emit LogAnySwapTradeTokensForNative(
                _path,
                _from,
                _to,
                _amountIn,
                _amountOutMin,
                _cID,
                _toChainID
            );
        }
    }

    // sets up a cross-chain trade from this chain to `toChainID` for `path` trades to `to`
    function anySwapOutExactTokensForNativeUnderlyingWithTransferPermit(
        address from,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 toChainID
    ) external virtual ensure(deadline) {
        IERC20(AnyswapV1ERC20(path[0]).underlying()).transferWithPermit(
            from,
            path[0],
            amountIn,
            deadline,
            v,
            r,
            s
        );
        AnyswapV1ERC20(path[0]).depositVault(amountIn, from);
        AnyswapV1ERC20(path[0]).burn(from, amountIn);
        emit LogAnySwapTradeTokensForNative(
            path,
            from,
            to,
            amountIn,
            amountOutMin,
            cID(),
            toChainID
        );
    }

    // Swaps `amounts[path.length-1]` `path[path.length-1]` to `to` on this chain
    // Triggered by `anySwapOutExactTokensForNative`
    function anySwapInExactTokensForNative(
        bytes32 txs,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline,
        uint256 fromChainID
    )
        external
        virtual
        onlyMPC
        ensure(deadline)
        returns (uint256[] memory amounts)
    {
        require(
            path[path.length - 1] == wNATIVE,
            "AnyswapV3Router: INVALID_PATH"
        );
        amounts = ISushiswapV2Proxy(sushiProxy).getAmountsOut(amountIn, path);
        require(
            amounts[amounts.length - 1] >= amountOutMin,
            "AnyswapV3Router: INSUFFICIENT_OUTPUT_AMOUNT"
        );
        _anySwapIn(
            txs,
            path[0],
            ISushiswapV2Proxy(sushiProxy).pairFor(path[0], path[1]),
            amounts[0],
            fromChainID
        );
        _swap(amounts, path, address(this));
        TransferHelper.safeTransfer(wNATIVE, to, amounts[amounts.length - 1]);
    }

    // **** SWAP ****
    // requires the initial amount to have already been sent to the first pair
    function _swap(
        uint256[] memory amounts,
        address[] memory path,
        address _to
    ) internal virtual {
        ISushiswapV2Proxy(sushiProxy).swap(amounts, path, _to);
    }
}
