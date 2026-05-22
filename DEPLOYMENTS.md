# Deployments

## X Layer Testnet (chain 1952)

**Deployed:** 2026-05-22T08:45Z
**Deployer:** `0x57153c1910200E18a24519812B085467F3541278` (Jeskins persona)

| Contract | Address | Tx |
|---|---|---|
| WorldCupCards (ERC1155) | [`0xC8EBbcb28d651439dCB0D5Fa216De2DCdC55b15a`](https://www.okx.com/web3/explorer/xlayer-test/address/0xc8ebbcb28d651439dcb0d5fa216de2dcdc55b15a) | broadcast/Deploy.s.sol/1952/run-latest.json |
| AdminMatchResolver | [`0x4a329Ce90EfB8f7c8Bbd9176C4aFA9da242041E8`](https://www.okx.com/web3/explorer/xlayer-test/address/0x4a329ce90efb8f7c8bbd9176c4afa9da242041e8) | broadcast/Deploy.s.sol/1952/run-latest.json |

Post-deploy: `WorldCupCards.setResolver(AdminMatchResolver)` — already wired in deploy script.

## RPC

- `https://testrpc.xlayer.tech/terigon`
- Chain ID: 1952

## Proof artifacts

- `broadcast/Deploy.s.sol/1952/run-latest.json` — full forge broadcast record
