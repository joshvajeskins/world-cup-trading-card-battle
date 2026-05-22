# Feature Matrix

Hackathon: X Layer X Cup Hackathon 2026
Idea: World Cup Trading Card Battle

| Feature / claim | Source evidence | Implementation path | Test / proof | Status | Gap / blocker |
|---|---|---|---|---|---|
| 12 seeded World Cup card templates | Council `TOP_10.json` rank 3 and red-team scope: "12 seeded cards" / "no custom art pipeline" | `src/cards.ts`, `contracts/src/WorldCupCards.sol` | `forge test`; screenshots `outputs/screenshots/home-*.png` | tested | Uses abstract nation-color cards, no licensed assets. |
| ERC1155-style card ownership | Gabriel hard override asks for real ERC1155/card contracts | `contracts/src/WorldCupCards.sol` | `forge test`: 5 passed | tested | Minimal ERC1155-compatible events/balances, not OpenZeppelin import. |
| Mint three cards | Council demo path: "Mint 3 cards" | Contract `mintStarterPack`; UI lineup preview | `testMintSubmitResolveAndBattle` | tested | Live chain tx blocked until funded deployer exists. |
| Submit three-card lineup | Council demo path: "submit lineup" | Contract `submitLineup`; UI selected slots | `testMintSubmitResolveAndBattle`; browser proof | tested | Live chain tx blocked until funded deployer exists. |
| Explicit admin resolver stats | Gabriel override allows explicit admin resolver contract path | `contracts/src/AdminMatchResolver.sol`; UI label | `testOnlyOwnerCanResolveFixture`, `testOnlyResolverCanApplyStats` | tested | Labeled as admin resolver demo fixture, not live sports API. |
| Upgrade traits from stats | Council demo path: "resolve stats -> upgrade traits" | Contract stat application and `CardTraitsUpgraded` events | `testMintSubmitResolveAndBattle` | tested | Live chain tx blocked until funded deployer exists. |
| Deterministic battle result | Council technical wedge: battle-result events | Contract battle score algorithm and `BattleResolved` event | `testMintSubmitResolveAndBattle` | tested | Live chain tx blocked until funded deployer exists. |
| Event/proof rail in UI | Sponsor/research requirement for verifiable X Layer evidence | `src/App.tsx` | Browser proof screenshots `flow-resolved-*.png` | tested | UI proof rail is local demo evidence, not explorer proof. |
| X Layer RPC smoke | Gabriel override asks X Layer RPC smoke checks | `pnpm smoke:xlayer` | Output: `1952` | tested | RPC works; deployment funding missing. |
| X Layer deployment script | Gabriel override prefers deployment scripts | `scripts/Deploy.s.sol`, `DEPLOYMENTS.md` | `forge script scripts/Deploy.s.sol:Deploy` dry-run succeeded | implemented | Broadcast requires `XLAYER_PRIVATE_KEY` with OKB. |
| High-end template-inspired landing/product UI | Template instructions and UI plan | Vite React app with liquid-glass card battle UI | Local visual QA 375/768/1440 passed | tested | Formal `/polish` blocked by M2 SSH timeout. |

Statuses: planned, implemented, tested, blocked, removed.
