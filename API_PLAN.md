# API Plan

Last updated: 2026-05-22T01:38:16Z

## Backend Shape

This MVP does not require a centralized production backend. The source of truth is contracts plus a small static catalog:

- `contracts/src/WorldCupCards.sol`: ERC1155 card ownership, card metadata traits, lineup entry, and battle scoring.
- `contracts/src/AdminMatchResolver.sol`: explicit admin resolver for fixture stat submission.
- `src/cards.ts`: labeled static card catalog and demo fixture copy.
- `src/App.tsx`: fixture-labeled local preview and event/proof rail.

## Data Model

| Entity | Fields | Source |
|---|---|---|
| Card template | `id`, `nation`, `role`, `attack`, `control`, `defense`, `rarity` | Static labeled seed catalog. |
| Owned card | `owner`, `cardId`, `balance`, upgraded trait values | ERC1155 contract reads/events. |
| Lineup | `owner`, three `cardIds`, score seed | Contract state. |
| Fixture stat | `fixtureId`, `goals`, `assists`, `saves`, `duelsWon`, `resolvedAt` | Admin resolver contract event. |
| Battle result | `player`, `opponent`, `lineupScore`, `opponentScore`, `winner` | Contract event. |

## Secrets

| Secret | Required for | Policy |
|---|---|---|
| `XLAYER_PRIVATE_KEY` | X Layer testnet deployment and smoke tx. | Never commit. If missing, deployment is blocked. |
| `VITE_WORLDCUP_CARDS_ADDRESS` | Web UI live contract mode. | Optional local env only. |
| `VITE_XLAYER_RPC_URL` | Web UI read-only X Layer mode. | Public RPC ok. |

## Real Integration Proof Path

1. `cast chain-id --rpc-url https://testrpc.xlayer.tech/terigon` proves RPC access.
2. `forge test` proves contract transitions locally.
3. `forge script ... --rpc-url $XLAYER_TESTNET_RPC_URL --broadcast` deploys if funded key exists.
4. Current UI shows fixture-labeled local preview. A future wallet/write mode should read deployed addresses after funding and deployment.

## Fallback Policy

If a live sports-data API is unavailable, the admin resolver is the real integration path for demo settlement. It is not a hidden mock because the resolver is an explicit contract with emitted events and admin-only write semantics.
