# Deployments

Last updated: 2026-05-22T01:38:16Z

## X Layer Testnet

- Chain ID: `1952`
- RPC smoke: passed, `cast chain-id --rpc-url https://testrpc.xlayer.tech/terigon` returned `1952`.
- `WorldCupCards`: blocked, no `XLAYER_PRIVATE_KEY` or funded deployer available yet.
- `AdminMatchResolver`: blocked, no `XLAYER_PRIVATE_KEY` or funded deployer available yet.
- Explorer: `https://www.okx.com/web3/explorer/xlayer-test`
- Local deployment dry-run: `forge script scripts/Deploy.s.sol:Deploy` succeeded; returned local dry-run addresses only, not X Layer addresses.

## Deploy Command

```bash
export XLAYER_TESTNET_RPC_URL=https://testrpc.xlayer.tech/terigon
forge script scripts/Deploy.s.sol:Deploy \
  --rpc-url "$XLAYER_TESTNET_RPC_URL" \
  --private-key "$XLAYER_PRIVATE_KEY" \
  --broadcast
```

Do not run broadcast without a Gabriel-approved funded deployer path.
