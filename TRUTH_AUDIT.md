# Truth Audit

Hackathon: X Layer X Cup Hackathon 2026
Idea: World Cup Trading Card Battle

| Claim | Reality: real / fixture / mock / blocked / not attempted / removed | Evidence | User-facing label needed? | Action |
|---|---|---|---|---|
| Product is working | real local demo | `pnpm build` passed; browser proof at `http://127.0.0.1:5177/` | no | Keep local-only status unless deployed. |
| Card contracts are real | real | `contracts/src/WorldCupCards.sol`, `contracts/src/AdminMatchResolver.sol`; `forge test` 5 passed | no | Ready for funded deployment. |
| Stats come from live World Cup API | removed | MVP chooses explicit admin resolver path | yes | Do not claim live sports data. |
| Stats come through admin resolver contract | real local contract path | Resolver contract and tests implemented; UI label present | yes | Deploy when funded key exists. |
| X Layer RPC is reachable | real | `pnpm smoke:xlayer` -> `1952` | no | Recorded in quality gate. |
| Contracts are deployed on X Layer | blocked | Requires funded `XLAYER_PRIVATE_KEY` or approved wallet signing path; env vars missing | yes | Gabriel must provide funded deployer private key or approved wallet path. |
| GitHub repo exists under Jeskins | blocked | Browser proved Jeskins GitHub; CLI auth is not Jeskins | yes | Gabriel must provide Jeskins PAT/CLI auth or approve another owner. |
| Submission portal is prepared | real field inventory | Google Form opened under Jeskins; required fields identified | no | Await repo/deploy/X post before filling. |
| X account posted/tagged `@XLayerOfficial` | not attempted | No approved exact content | yes | Generate templates only unless Gabriel approves posting. |
| Test/seed fixture data is used | fixture | `src/cards.ts`, contract seeded cards, UI fixture source label | yes | Kept separate from live sports/API claims. |

Rules:
- Do not claim live, onchain, deployed, submitted, verified, paid, sent, minted, uploaded, or connected without evidence.
- Fixtures are allowed only when visible in UI, README, demo script, and QUALITY_GATE.md.
