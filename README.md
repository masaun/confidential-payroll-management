# Confidential Payroll Management Platform

(Forked from the [`"Aztec Standards"`](https://github.com/defi-wonderland/aztec-standards) repo, which is powered by DeFi Wonderland)

<br>

## Techinical Stack

- `aztec` package: `v2.0.3` (Not `v1.2.0`)
- `aztec-nargo`: `v1.0.0-beta.11` (or the `latest` version)
- `Noir`: `v1.0.0-beta.11`

<br>

## Installation

- Install the `aztec-nargo` module `v1.0.0-beta.11` (or the `latest` version) into the **local machine**:
```bash
aztec-up -v latest
```

<br>

- Install the `Noir` lang `v1.0.0-beta.11` into the **local machine**:
```bash
noirup --version 1.0.0-beta.11
```

<br>

## SC test

- 0/ Move the root directory (i.e. The root directory of the Dripper contract):
```bash
cd src/dripper
```

<br>

- 1/ Compile the SCs:
```bash
aztec-nargo compile
```

<br>

- 2/ Run the SC test
```bash
aztec test
```



<br>

## Deploy a SC on Aztec `Testnet`
- TBD

<br>

<hr>


# Aztec Standards

[![npm version](https://img.shields.io/npm/v/@defi-wonderland/aztec-standards.svg)](https://www.npmjs.com/package/@defi-wonderland/aztec-standards)

Aztec Standards is a comprehensive collection of reusable, standardized contracts for the Aztec Network. It provides a robust foundation of token primitives and utilities that support both private and public operations, empowering developers to build innovative privacy-preserving applications with ease.

## Table of Contents
- [Dripper Contract](#dripper-contract)
- [Token Contract](#token-contract)
- [NFT Contract](#nft-contract)
- [Future Contracts](#future-contracts)

## Dripper Contract

The `Dripper` contract provides a convenient faucet mechanism for minting tokens into private or public balances. Anyone can easily invoke the functions to request tokens for testing or development purposes.

📖 **[View detailed Dripper documentation](src/dripper/README.md)**

## Token Contract

The `Token` contract implements an ERC-20-like token with Aztec-specific privacy extensions. It supports transfers and interactions explicitly through private balances and public balances, offering full coverage of Aztec's confidentiality features.

We published the [AIP-20 Aztec Token Standard](https://forum.aztec.network/t/request-for-comments-aip-20-aztec-token-standard/7737) to the forum. Feel free to review and discuss the specification there.

📖 **[View detailed Token documentation](src/token_contract/README.md)**

## NFT Contract

The `NFT` contract implements an ERC-721-like non-fungible token with Aztec-specific privacy extensions. It supports transfers and interactions through both private and public ownership, offering full coverage of Aztec's confidentiality features for unique digital assets.

📖 **[View detailed NFT documentation](src/nft_contract/README.md)**

## Future Contracts

Additional standardized contracts (e.g., staking, governance, pools) will be added under this repository, with descriptions and function lists.