# Integration Matrix

Hackathon: X Layer X Cup Hackathon 2026
Idea: World Cup Trading Card Battle

| Dependency | Real access path | Env / credential | Proof command or browser proof | Fixture policy | Status | Blocker |
|---|---|---|---|---|---|---|
| X Layer testnet RPC | Official docs: `https://testrpc.xlayer.tech/terigon` or `https://xlayertestrpc.okx.com/terigon` | None | `cast chain-id --rpc-url https://testrpc.xlayer.tech/terigon` -> `1952` | No fixture; live RPC only | tested | None. |
| X Layer deployment | Foundry script to X Layer testnet chain `1952` | `XLAYER_PRIVATE_KEY` funded with OKB | Dry-run: `forge script scripts/Deploy.s.sol:Deploy`; broadcast pending | No simulated deployment claim allowed | blocked | `XLAYER_PRIVATE_KEY`, `PRIVATE_KEY`, and `DEPLOYER_PRIVATE_KEY` are missing. |
| X Layer explorer | `https://www.okx.com/web3/explorer/xlayer-test` | None | Explorer URL for deployed contract/tx | No fixture | blocked | Requires deployment first. |
| Admin fixture resolver | Deployed/local `AdminMatchResolver` contract | Deployer/admin wallet | `forge test` covers owner-only fixture resolution and trait forwarding | Labeled as admin resolver demo fixture | tested | Live deployment blocked by missing funded key. |
| Live sports/stat API | Public fixture/stat ingestion only if found/wired | TBD | API response + resolver transaction | Not used in MVP unless proven | removed | Explicit admin resolver path chosen instead. |
| Web wallet | Browser wallet if available in profile | User-approved wallet signature path | Manual/browser proof only if wallet works | UI must state local demo if no wallet | planned | Need wallet availability/funding. |
| GitHub repo | Jeskins Chrome profile `Profile 4` | Logged-in GitHub profile | `agent-browser` proved `Joshva Jeskins (joshvajeskins)` | Not applicable | blocked | CLI auth is Gabriel/CipherKuma, not Jeskins; need Jeskins PAT/CLI auth or approved push path. |
| Submission portal | Official X Cup page -> Google Form | Jeskins Google session | `agent-browser` opened form and inventoried fields | Not applicable | tested | Required fields disabled until response-email checkbox; no final submit. |
| Dedicated X account/action | Jeskins/X project account path | Logged-in X profile | Draft/post URL only after approval | Generated post templates are not live posts | planned | Posting requires Gabriel approval. |

Every external API, wallet, contract, dashboard, repo, submission portal, and browser identity must be listed here.
