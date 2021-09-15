# L2Router
### 配置

#### Rinkeby 测试网
- Chain ID - 4
- https://rinkeby.infura.io/v3/
- 浏览器 - https://rinkeby.etherscan.io/
- 确认数 - 3
- 初始块高 - 9106500

#### BOBA-Rinkeby 测试网 (OMGX)
- Chain ID - 28
- RPC - https://rinkeby.boba.network
- 浏览器 - https://blockexplorer.rinkeby.omgx.network/?network=OmgX
- L1 => L2 跨链桥 - https://webwallet.rinkeby.omgx.network/
- 确认数 - 1
- 初始块高 - 3899

#### Optimism-Kovan 测试网
- Chain ID - 69
- RPC - https://kovan.optimism.io
- Websocket - wss://kovan.optimism.io:8546
- 浏览器 - https://kovan-l2-explorer.surge.sh
- 浏览器 - https://kovan-optimistic.etherscan.io/
- L1 => L2 跨链桥 - https://gateway.optimism.io/
- 确认数 - 1
- 初始块高 - 1069187

#### Arbitrum-Rinkeby 测试网
- Chain ID - 421611
- RPC - https://rinkeby.arbitrum.io/rpc
- 浏览器 - https://rinkeby-explorer.arbitrum.io/#/
- L1 => L2 跨链桥 - https://bridge.arbitrum.io
- 确认数 - 1
- 初始块高 - 1865522

### 合约
### Rinkeby L1 testnet
| Contract | Contract address |
| - | - |
| Router config | 0x8ca2ecbce34c322fcea6db912d9dbfd2dda5920d |
| wETH | 0xecb6d48e04d1df057e398b98ac8b3833eb3839ec |
| Any ETH | 0x7beb05cf5681f402e762f8569c2fc138a2172978 |
| Underlying USD | 0x323a07f929f7c4db7631866af151248ae3912d98 |
| Any USD | 0x685b63cfe0179b3efb70a01dcb1d648549aa192d |
| Router | 0xd3923c56ab830590fd1998c9e9ed360296e082fc |
| Multicall | 0xd652776de7ad802be5ec7bebfafda37600222b48 |

### Arbitrum-Rinkeby testnet
| Contract | Contract address |
| - | - |
| wETH | 0x338726dd694db9e2230ec2bb8624a2d7f566c96d |
| Any ETH | 0x595c8481c48894771ce8fade54ac6bf59093f9e8 |
| Underlying USD | 0x80A16016cC4A2E6a2CACA8a4a498b1699fF0f844 |
| Any USD | 0xb153fb3d196a8eb25522705560ac152eeec57901 |
| Router | 0xcb58418aa51ba525aef0fe474109c0354d844b7c |
| Multicall | 0xf27ee99622c3c9b264583dacb2cce056e194494f |

### Optimism-Kovan testnet
| Contract | Contract address |
| - | - |
| OETH | 0x4200000000000000000000000000000000000006 |
| wETH ||
| Any ETH | 0x818ec0a7fe18ff94269904fced6ae3dae6d6dc0b |
| Underlying USD | 0x639a647fbe20b6c8ac19e48e2de44ea792c62c5c |
| Any USD | 0x765277eebeca2e31912c9946eae1021199b39c61 |
| Router | 0x7c598c96d02398d89fbcb9d41eab3df0c16f227d |
| Sushi proxy | 0x5d9ab5522c64e1f6ef5e3627eccc093f56167818 |
| Multicall | 0x332730a4f6e03d9c55829435f10360e13cfa41ff |

*Optimism-OETH will no longer implement WETH and ERC20.*

### Boba-Rinkeby testnet (OMGX)
| Contract | Contract address |
| - | - |
| OETH | 0x4200000000000000000000000000000000000006 |
| wETH | 0x6f058086d91a181007c2325e5b285425ca84d615 |
| Any ETH | 0x7ea2be2df7ba6e54b1a9c70676f668455e329d29 |
| Underlying USD | 0xdae6c2a48bfaa66b43815c5548b10800919c993e |
| Any USD | 0x1ccca1ce62c62f7be95d4a67722a8fdbed6eecb4 |
| Router | 0x965f84d915a9efa2dd81b653e3ae736555d945f4 |
| Sushi proxy | 0x9610b01aaa57ec026001f7ec5cface51bfea0ba6 |
| Multicall | 0x667fd83e24ca1d935d36717d305d54fa0cac991c |

*OMG-OETH implements WETH (hence ERC20), but may change in future.*
