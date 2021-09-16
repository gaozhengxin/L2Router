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
| Any ETH | 0xE6BF0E14e33A469F2b0640B53949A9F90E675135 |
| Underlying USDC | 0xa9f6da3A7ed89804B0C1B46eA118b2bcd77A2823 |
| Any USDC | 0xF2B3E3fA33232c639d4Ca5a26E4E95c490417C84 |
| Router | 0x5fC17416925789E0852FBFcd81c490ca4abc51F9 |
| TransferHelper | 0xECf2ADafF1De8A512f6e8bfe67a2C836EDb25Da3 |
| SafeMathSushiswap | 0x94977c9888F3D2FAfae290d33fAB4a5a598AD764 |
| Sushi proxy | 0x7D09a42045359Aa85488bC07D0ADa83E22d50017 |
| Multicall | 0x667fd83e24ca1d935d36717d305d54fa0cac991c |

*OMG-OETH implements WETH (hence ERC20), but may change in future.*
