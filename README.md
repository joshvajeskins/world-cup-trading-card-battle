# X Cup Card Battle

Hackathon: X Layer X Cup Hackathon 2026  
Tracks: GameFi, NFT

X Cup Card Battle is a scoped World Cup trading-card battle demo for X Layer. Fans mint ERC1155-style dynamic cards, submit a three-card lineup, then an explicit admin resolver contract posts fixture stats that upgrade card traits and emit a deterministic battle result.

## Truth Boundary

- Real code exists for contracts, tests, deploy script, and frontend.
- X Layer testnet RPC is reachable at chain ID `1952`.
- No live sports-data API is claimed. The demo uses an explicit `AdminMatchResolver` contract path.
- No X Layer deployment is claimed yet. Deployment is blocked until `XLAYER_PRIVATE_KEY` or an approved funded wallet-signing path is provided.
- UI fixture label: `Admin resolver demo fixture - not live sports API`.

## Run Locally

```bash
pnpm install
pnpm build
forge test
pnpm dev -- --port 5177
```

## X Layer RPC Smoke

```bash
pnpm smoke:xlayer
# expected: 1952
```

## Deploy When Funded

```bash
export XLAYER_TESTNET_RPC_URL=https://testrpc.xlayer.tech/terigon
forge script scripts/Deploy.s.sol:Deploy \
  --rpc-url "$XLAYER_TESTNET_RPC_URL" \
  --private-key "$XLAYER_PRIVATE_KEY" \
  --broadcast
```

Do not run broadcast without a Gabriel-approved funded deployer path.

## Proof Files

- `FEATURE_MATRIX.md`
- `INTEGRATION_MATRIX.md`
- `TRUTH_AUDIT.md`
- `QUALITY_GATE.md`
- `DEPLOYMENTS.md`
- `outputs/screenshots/`
