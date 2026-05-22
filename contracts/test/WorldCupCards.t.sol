// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/AdminMatchResolver.sol";
import "../src/WorldCupCards.sol";

contract WorldCupCardsTest is Test {
    WorldCupCards private cards;
    AdminMatchResolver private resolver;

    address private alice = address(0xA11CE);
    address private bob = address(0xB0B);

    function setUp() public {
        cards = new WorldCupCards();
        resolver = new AdminMatchResolver(address(cards));
        cards.setResolver(address(resolver));
    }

    function testMintSubmitResolveAndBattle() public {
        uint256[3] memory aliceCards = [uint256(1), uint256(2), uint256(3)];
        uint256[3] memory bobCards = [uint256(4), uint256(5), uint256(6)];

        vm.prank(alice);
        cards.mintStarterPack(aliceCards);
        vm.prank(alice);
        cards.submitLineup(aliceCards);

        vm.prank(bob);
        cards.mintStarterPack(bobCards);
        vm.prank(bob);
        cards.submitLineup(bobCards);

        uint256 strikerBefore = cards.cardPower(1);
        resolver.resolveFixture(1001, 3, 2, 5, 11);
        uint256 strikerAfter = cards.cardPower(1);

        assertGt(strikerAfter, strikerBefore);
        assertEq(cards.lastFixtureId(), 1001);

        vm.prank(alice);
        (uint256 aliceScore, uint256 bobScore, address winner) = cards.battle(bob);

        assertGt(aliceScore, 0);
        assertGt(bobScore, 0);
        assertTrue(winner == alice || winner == bob);
    }

    function testOnlyResolverCanApplyStats() public {
        vm.expectRevert("not resolver");
        cards.applyFixtureStats(1, 1, 1, 1, 1);
    }

    function testOnlyOwnerCanResolveFixture() public {
        vm.prank(alice);
        vm.expectRevert("not owner");
        resolver.resolveFixture(1, 1, 1, 1, 1);
    }

    function testRequiresOwnedCardsForLineup() public {
        uint256[3] memory ids = [uint256(1), uint256(2), uint256(3)];
        vm.prank(alice);
        vm.expectRevert("card not owned");
        cards.submitLineup(ids);
    }

    function testRejectsDuplicateLineupCards() public {
        uint256[3] memory ids = [uint256(1), uint256(1), uint256(2)];
        vm.prank(alice);
        vm.expectRevert("duplicate card");
        cards.mintStarterPack(ids);
    }
}
