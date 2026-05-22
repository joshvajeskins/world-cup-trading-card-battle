# Execution Packet

Last updated: 2026-05-22T01:38:16Z

## Project

`X Cup Card Battle` is a World Cup GameFi/NFT demo on X Layer where fans mint dynamic cards, submit a three-card lineup, and watch an explicit admin resolver settle fixture stats into card upgrades and deterministic battle results.

## Judge Mapping

| Criterion | Evidence plan |
|---|---|
| World Cup-native innovation | Dynamic match-stat card upgrades and lineup battles. |
| X Layer depth | ERC1155 cards, lineup, resolver, stat update, and battle result events deployable on X Layer. |
| Completion | Foundry tests, local web demo, browser proof, and deployment script. |
| Code quality | Solidity tests, TypeScript build, no hidden mocks. |
| Market potential | Repeat fan loop: mint, lineup, resolve, upgrade, battle, share proof. |

## Demo Script

1. Show the landing hero and fixture source label.
2. Mint/select three starter cards.
3. Submit the lineup.
4. Run the admin resolver demo fixture.
5. Show upgraded traits, battle score, and event/proof rail.
6. Show X Layer RPC/deployment status and explorer links if deployed.

## Video Script

Opening: "World Cup stats should not die in a feed; they should change the squad you own."

Core: "X Cup Card Battle turns a fixture stat into an on-chain card upgrade and battle result. The demo uses an explicit admin resolver contract path because the tournament has not started and no live feed is claimed."

Close: "Built for X Layer's low-cost repeated writes: mint, lineup, resolve, upgrade, battle, and share."

## Final Checklist

- [ ] `forge test`
- [ ] `pnpm build`
- [ ] X Layer RPC smoke
- [ ] Deployment attempt or funded-key blocker
- [ ] Browser proof
- [ ] Local visual QA screenshots at 375/768/1440
- [ ] Repo URL
- [ ] Portal field inventory
- [ ] Truth files updated
