// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IWorldCupCards {
    function applyFixtureStats(uint256 fixtureId, uint16 goals, uint16 assists, uint16 saves, uint16 duelsWon) external;
}

contract AdminMatchResolver {
    struct FixtureStats {
        uint16 goals;
        uint16 assists;
        uint16 saves;
        uint16 duelsWon;
        uint64 resolvedAt;
        bool resolved;
    }

    address public owner;
    IWorldCupCards public cards;
    mapping(uint256 => FixtureStats) public fixtureStats;

    event FixtureResolved(uint256 indexed fixtureId, uint16 goals, uint16 assists, uint16 saves, uint16 duelsWon);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    constructor(address cardsAddress) {
        require(cardsAddress != address(0), "cards zero");
        owner = msg.sender;
        cards = IWorldCupCards(cardsAddress);
    }

    function resolveFixture(uint256 fixtureId, uint16 goals, uint16 assists, uint16 saves, uint16 duelsWon) external onlyOwner {
        require(!fixtureStats[fixtureId].resolved, "already resolved");
        fixtureStats[fixtureId] = FixtureStats({
            goals: goals,
            assists: assists,
            saves: saves,
            duelsWon: duelsWon,
            resolvedAt: uint64(block.timestamp),
            resolved: true
        });
        cards.applyFixtureStats(fixtureId, goals, assists, saves, duelsWon);
        emit FixtureResolved(fixtureId, goals, assists, saves, duelsWon);
    }
}
