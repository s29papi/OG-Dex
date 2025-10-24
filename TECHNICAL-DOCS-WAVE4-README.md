
---

🧠 Technical Delivery — OG-Dex (Built on 0G Newton Testnet)

**Demo**:  
*Watch on YouTube (Placeholder: Insert link when available)*

### Overview
OG-Dex is a decentralized Automated Market Maker (AMM) exchange deployed on the 0G testnet (chain ID 16602), leveraging the constant product formula (x * y = k) to enable trustless token swaps. Built using Solidity and Foundry, it provides a Uniswap V2-inspired protocol for creating liquidity pools, swapping tokens, and adding/removing liquidity, all secured by the 0G blockchain's low-cost, high-throughput environment.

The project integrates a Factory contract for deploying pair contracts and a Router contract for user interactions, optimized for the 0G testnet's EIP-1559 gas dynamics. Despite deployment challenges with gas price enforcement (minimum 2 Gwei tip cap), we successfully deployed the core contracts, enabling a fully functional AMM DEX.

---

⚙️ **Core Accomplishments**
- **Constant Product AMM**: Implements the x * y = k formula for token pairs, ensuring predictable pricing and liquidity provision.
- **Factory Contract**: Deploys pair contracts for any ERC20 token pair, maintaining a registry of pools and enabling permissionless market creation.
- **Router Contract**: Facilitates user interactions (swaps, liquidity addition/removal) with slippage protection and deadline enforcement.
- **0G Testnet Deployment**: Successfully deployed on the 0G Newton testnet despite gas price challenges, using a manual `cast` workaround to bypass Foundry's gas estimation issues.
- **EIP-1559 Compatibility**: Configured transactions to meet the network’s 2 Gwei minimum tip cap, adapting to dynamic base fees (~0.05-0.1 Gwei).
- **Immutable Pair Creation**: Pair contracts are deterministically created via CREATE2, ensuring reproducible addresses.
- **Gas Optimization**: Router functions optimized for gas efficiency, critical for 0G’s low-cost environment.
- **Safe Math**: Uses Solidity 0.8.x safe math to prevent overflows, ensuring robust calculations.

---

🧩 **Design Decisions**

| **Component**          | **Role**                                      | **Reasoning**                                                                 |
|------------------------|----------------------------------------------|------------------------------------------------------------------------------|
| Constant Product Formula | Core pricing mechanism                       | Proven, simple, and widely adopted (Uniswap V2), ensuring reliable swaps      |
| Factory Contract        | Pair creation and registry                   | Enables permissionless pool creation with minimal governance                  |
| Router Contract         | User interface for swaps/liquidity           | Simplifies interactions with pools, supporting complex operations like swaps   |
| CREATE2                 | Deterministic pair deployment                | Ensures predictable pair addresses, simplifying integrations                  |
| Solidity 0.8.28         | Contract implementation                      | Safe math and modern features reduce bugs and improve security                |
| Foundry + Cast          | Development and deployment                   | Industry-standard tooling for testing and deployment, despite gas issues      |
| 0G Newton Testnet       | Deployment environment                       | Low-cost, EIP-1559-compatible chain for testing AMM scalability               |

---

🧠 **How It Works**
1. **Factory Deployment**: The Factory contract (`0x2a6dD0AE448d7ff534A485Eed2EB66B07c34Bed2`) creates pair contracts for any ERC20 token pair using CREATE2, storing pair addresses in a mapping.
2. **Pair Creation**: Users call `createPair(tokenA, tokenB)` on the Factory, deploying a new pair contract with the constant product formula (x * y = k).
3. **Liquidity Provision**: Users add liquidity via the Router (`0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74`), which interacts with pairs to mint LP tokens.
4. **Token Swaps**: The Router’s `swapExactTokensForTokens` or `swapTokensForExactTokens` functions execute swaps, enforcing price bounds and deadlines.
5. **Gas Handling**: Transactions use EIP-1559 (or legacy fallback) with a minimum 2 Gwei tip cap to meet 0G’s validator requirements.
6. **Price Oracle**: Cumulative price updates in pairs provide a time-weighted average price (TWAP) for external use.

**Flow**:  
`User → Router → Pair → Swap or Liquidity Operation`  
`Factory → CREATE2 → New Pair (x * y = k)`

---

💻 **Example Usage**
- **Create a Pair**:
  ```bash
  cast call 0x2a6dD0AE448d7ff534A485Eed2EB66B07c34Bed2 \
    "createPair(address,address)(address)" \
    <tokenA> <tokenB> \
    --rpc-url https://evmrpc-testnet.0g.ai
  ```
- **Add Liquidity**:
  ```bash
  cast send 0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74 \
    "addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256)" \
    <tokenA> <tokenB> <amountA> <amountB> <minA> <minB> <to> <deadline> \
    --rpc-url https://evmrpc-testnet.0g.ai \
    --private-key $PRIVATE_KEY
  ```
- **Swap Tokens**:
  ```bash
  cast send 0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74 \
    "swapExactTokensForTokens(uint256,uint256,address[],address,uint256)" \
    <amountIn> <amountOutMin> <path> <to> <deadline> \
    --rpc-url https://evmrpc-testnet.0g.ai \
    --private-key $PRIVATE_KEY
  ```

---

🏁 **Outcome**
OG-Dex delivers a fully functional AMM DEX on the 0G Newton testnet, enabling permissionless token swaps and liquidity provision using the constant product formula. Despite deployment challenges (Foundry submitting 1 wei tip cap instead of 2.5 Gwei), we used a manual `cast send --create` workaround to deploy the Router contract, ensuring compatibility with the network’s 2 Gwei minimum gas tip requirement.

The DEX is gas-efficient, secure, and scalable, leveraging 0G’s low-cost environment to make DeFi accessible. It serves as a foundation for decentralized trading on 0G, with potential for mainnet deployment and integration with other DeFi protocols.

---

### Deployments
**Factory**  
- **Deployer**: `0x330cA32b71b81Ea2b1D3a5C391C5cFB6520E0A10`  
- **Deployed to**: `0x2a6dD0AE448d7ff534A485Eed2EB66B07c34Bed2`  
- **Transaction Hash**: `0x6ae7c9aaffe2a33d75dd7667ddffc68efaab5ebad7e88081eb4cea807f606ecc`  
- **Tx Hash URL**: [https://chainscan-galileo.0g.ai/tx/0x6ae7c9aaffe2a33d75dd7667ddffc68efaab5ebad7e88081eb4cea807f606ecc](https://chainscan-galileo.0g.ai/tx/0x6ae7c9aaffe2a33d75dd7667ddffc68efaab5ebad7e88081eb4cea807f606ecc)  
- **Factory URL**: [https://chainscan-galileo.0g.ai/address/0x2a6dd0ae448d7ff534a485eed2eb66b07c34bed2](https://chainscan-galileo.0g.ai/address/0x2a6dd0ae448d7ff534a485eed2eb66b07c34bed2)

**Router**  
- **Deployer**: `0x330cA32b71b81Ea2b1D3a5C391C5cFB6520E0A10`  
- **Deployed to**: `0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74`  
- **Transaction Hash**: `0x1df39d8ca81200c516d618f33ba1480800bed5caeebfde9aef54e88d869af79d`  
- **Tx Hash URL**: [https://chainscan-galileo.0g.ai/tx/0x1df39d8ca81200c516d618f33ba1480800bed5caeebfde9aef54e88d869af79d](https://chainscan-galileo.0g.ai/tx/0x1df39d8ca81200c516d618f33ba1480800bed5caeebfde9aef54e88d869af79d)  
- **Router URL**: [https://chainscan-galileo.0g.ai/address/0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74](https://chainscan-galileo.0g.ai/address/0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74)

---

### Deployment Challenges and Resolution
**Issue**: Initial attempts to deploy the Router contract using `forge create` failed with the error: "transaction gas price below minimum: gas tip cap 1, minimum needed 2000000000." Foundry submitted transactions with a 1 wei tip cap, ignoring `--max-priority-fee-per-gas 2500000000` and `--gas-price 5000000000` flags.

**Root Cause**: Likely a Foundry bug or RPC misconfiguration on the 0G testnet, causing gas estimation to default to 1 wei for the tip cap, violating the network’s 2 Gwei minimum.

**Solution**: We bypassed `forge create` and used `cast send --create` to manually deploy the Router with the following command:
```bash
cast send --rpc-url https://evmrpc-testnet.0g.ai \
  --private-key $PRIVATE_KEY \
  --create <bytecode_with_args> \
  --gas-price 5000000000 \
  --gas-limit 1000000 \
  --legacy
```
- Bytecode was obtained via `forge inspect UnifapV2Router bytecode`.
- Constructor args were ABI-encoded: `cast abi-encode "constructor(address)" 0x2a6dD0AE448d7ff534A485Eed2EB66B07c34Bed2`.
- Legacy mode (`--legacy`) with a 5 Gwei gas price ensured compliance with the network’s requirements.

**Recommendation**: Update Foundry (`foundryup`) and check 0G’s Discord (#developers, discord.gg/0glabs) for RPC or gas policy updates.

---

This deliverable captures the essence of OG-Dex, its AMM mechanics, and the deployment journey. If you need specific tweaks (e.g., adding a YouTube demo link, code snippets, or test cases), let me know!