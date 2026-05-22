# Build Plan

Last updated: 2026-05-22T01:38:16Z

## Stack

- Contracts: Foundry Solidity tests and scripts.
- Contract standard: ERC1155-style implementation with local minimal interfaces to avoid opaque dependencies.
- Web: Vite + React + TypeScript, CSS modules/plain CSS, `viem` for reads/writes where a wallet is available.
- Browser proof: local dev server plus screenshot/flow proof at 375, 768, and 1440.

## MVP Scope

1. `WorldCupCards` contract mints seeded cards, stores lineup, accepts resolver stats, upgrades traits, and emits battle events.
2. `AdminMatchResolver` records fixture stats through an admin-only function and forwards them to cards.
3. Web UI shows card catalog, selected lineup, admin-resolver fixture label, event rail, battle score, and X Layer proof status.
4. README, deployment docs, truth audit, quality gate, demo script, and builder report remain honest about real vs fixture vs blocked.

## Demo Path

1. Open app.
2. Inspect card catalog and labeled fixture source.
3. Run local demo flow or wallet-connected flow.
4. See cards minted/selected, stats resolved, traits upgraded, and battle result emitted.
5. Review proof panel: local tests and RPC smoke proof; deployment status if funded key exists.

## Milestones

| Milestone | Target | Status |
|---|---|---|
| Planning/truth files | 2026-05-22T01:50:00Z | in progress |
| Contract compile/tests | 2026-05-22T02:20:00Z | complete |
| Web implementation | 2026-05-22T03:00:00Z | complete |
| Browser/local visual QA | 2026-05-22T03:30:00Z | complete |
| Repo/portal/browser preflight | 2026-05-22T03:45:00Z | complete-with-blocker |
| Final report | 2026-05-22T04:00:00Z | in progress |

## Non-Negotiables

- No fake deployment claim.
- No hidden mock sports feed.
- No X posting, legal attestation, or final submission without Gabriel's explicit approval.
- If deployment key/funding is missing, write a precise blocker and keep build work moving.
