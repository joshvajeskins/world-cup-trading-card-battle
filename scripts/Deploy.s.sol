// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../contracts/src/AdminMatchResolver.sol";
import "../contracts/src/WorldCupCards.sol";

contract Deploy is Script {
    function run() external returns (WorldCupCards cards, AdminMatchResolver resolver) {
        vm.startBroadcast();
        cards = new WorldCupCards();
        resolver = new AdminMatchResolver(address(cards));
        cards.setResolver(address(resolver));
        vm.stopBroadcast();
    }
}
