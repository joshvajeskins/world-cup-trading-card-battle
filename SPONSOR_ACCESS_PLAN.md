# Sponsor Access Plan

Last updated: 2026-05-22T01:38:16Z

## Official Surfaces

| Surface | URL / access path | Use | Status |
|---|---|---|---|
| X Cup official page | `https://web3.okx.com/xlayer/build-x-hackathon/xcup` | Rules, submission link, judging requirements. | Read via council mirror and current web search. |
| X Layer network docs | `https://web3.okx.com/xlayer/docs/developer/build-on-xlayer/network-information` | RPC, chain ID, explorer. | Read via current web search. |
| X Layer testnet RPC | `https://testrpc.xlayer.tech/terigon`, `https://xlayertestrpc.okx.com/terigon` | RPC smoke, deployment target. | Smoke pending. |
| X Layer testnet explorer | `https://www.okx.com/web3/explorer/xlayer-test` | Deployment and tx proof. | Blocked until deployment. |
| GitHub | `https://github.com/new` with Jeskins profile | Public repo creation. | Browser preflight pending. |
| Submission portal | Google Form linked from official page | Draft inventory and final package. | Browser preflight pending; no final submit without Gabriel approval. |
| X/Twitter project account | Jeskins profile on `x.com` unless portal requires project account creation | Required active posting/tagging plan. | Account action not attempted; posting requires Gabriel approval for exact content. |

## Real State Transition To Prove

1. Wallet mints three ERC1155 cards.
2. Wallet submits a three-card lineup.
3. Admin resolver posts labeled fixture stats to contract.
4. Contract upgrades card traits from resolver stats.
5. Contract emits battle result from deterministic scoring.
6. UI reads events/state and shows transaction hashes or local chain event IDs.

## Access/Funding Blockers

- A live X Layer deployment requires a funded deployer private key in `XLAYER_PRIVATE_KEY` or an approved wallet signature path.
- If no funded key/wallet is available, the project remains real local-contract-tested and deployment-blocked, not falsely onchain.

## Fixture Policy

- Demo fixture stats are allowed only through the explicit `AdminMatchResolver` contract path.
- Test fixtures live only in tests/seed scripts and must be labeled in UI, README, `TRUTH_AUDIT.md`, and `QUALITY_GATE.md`.
