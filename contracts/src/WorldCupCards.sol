// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract WorldCupCards {
    struct CardTemplate {
        string name;
        string nation;
        string role;
        uint16 attack;
        uint16 control;
        uint16 defense;
        uint8 rarity;
    }

    struct TraitBoost {
        uint16 attack;
        uint16 control;
        uint16 defense;
        uint8 level;
    }

    struct Lineup {
        uint256[3] cardIds;
        bool submitted;
    }

    string public constant name = "X Cup Card Battle";
    string public constant symbol = "XCUPCARD";

    address public owner;
    address public resolver;
    uint256 public lastFixtureId;

    mapping(address => mapping(uint256 => uint256)) private balances;
    mapping(uint256 => CardTemplate) private templates;
    mapping(uint256 => TraitBoost) public boosts;
    mapping(address => Lineup) private lineups;

    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);
    event ResolverSet(address indexed resolver);
    event StarterPackMinted(address indexed player, uint256[3] cardIds);
    event LineupSubmitted(address indexed player, uint256[3] cardIds);
    event FixtureStatsApplied(uint256 indexed fixtureId, uint16 goals, uint16 assists, uint16 saves, uint16 duelsWon);
    event CardTraitsUpgraded(uint256 indexed cardId, uint16 attack, uint16 control, uint16 defense, uint8 level);
    event BattleResolved(address indexed challenger, address indexed opponent, uint256 challengerScore, uint256 opponentScore, address winner);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier onlyResolver() {
        require(msg.sender == resolver, "not resolver");
        _;
    }

    constructor() {
        owner = msg.sender;
        _seedCards();
    }

    function setResolver(address nextResolver) external onlyOwner {
        require(nextResolver != address(0), "resolver zero");
        resolver = nextResolver;
        emit ResolverSet(nextResolver);
    }

    function balanceOf(address account, uint256 id) external view returns (uint256) {
        return balances[account][id];
    }

    function cardTemplate(uint256 id) external view returns (CardTemplate memory) {
        _requireCard(id);
        return templates[id];
    }

    function cardPower(uint256 id) public view returns (uint256) {
        _requireCard(id);
        CardTemplate storage template = templates[id];
        TraitBoost storage boost = boosts[id];
        return uint256(template.attack + boost.attack) + uint256(template.control + boost.control) + uint256(template.defense + boost.defense);
    }

    function lineupOf(address player) external view returns (Lineup memory) {
        return lineups[player];
    }

    function mintStarterPack(uint256[3] calldata cardIds) external {
        _requireUniqueLineup(cardIds);
        for (uint256 i = 0; i < 3; i++) {
            _requireCard(cardIds[i]);
            balances[msg.sender][cardIds[i]] += 1;
            emit TransferSingle(msg.sender, address(0), msg.sender, cardIds[i], 1);
        }
        emit StarterPackMinted(msg.sender, cardIds);
    }

    function submitLineup(uint256[3] calldata cardIds) external {
        _requireUniqueLineup(cardIds);
        for (uint256 i = 0; i < 3; i++) {
            _requireCard(cardIds[i]);
            require(balances[msg.sender][cardIds[i]] > 0, "card not owned");
        }
        lineups[msg.sender] = Lineup({ cardIds: cardIds, submitted: true });
        emit LineupSubmitted(msg.sender, cardIds);
    }

    function applyFixtureStats(uint256 fixtureId, uint16 goals, uint16 assists, uint16 saves, uint16 duelsWon) external onlyResolver {
        require(fixtureId > lastFixtureId, "fixture already applied");
        lastFixtureId = fixtureId;

        uint16 attackBoost = goals * 2 + assists;
        uint16 controlBoost = assists * 2 + duelsWon;
        uint16 defenseBoost = saves * 2 + duelsWon;

        for (uint256 id = 1; id <= 12; id++) {
            TraitBoost storage boost = boosts[id];
            CardTemplate storage template = templates[id];
            if (_sameRole(template.role, "Striker")) boost.attack += attackBoost;
            if (_sameRole(template.role, "Playmaker")) boost.control += controlBoost;
            if (_sameRole(template.role, "Keeper")) boost.defense += defenseBoost;
            if (_sameRole(template.role, "Anchor")) {
                boost.attack += goals;
                boost.control += duelsWon;
                boost.defense += saves;
            }
            boost.level += 1;
            emit CardTraitsUpgraded(id, boost.attack, boost.control, boost.defense, boost.level);
        }

        emit FixtureStatsApplied(fixtureId, goals, assists, saves, duelsWon);
    }

    function battle(address opponent) external returns (uint256 challengerScore, uint256 opponentScore, address winner) {
        require(lineups[msg.sender].submitted, "challenger lineup missing");
        require(lineups[opponent].submitted, "opponent lineup missing");

        challengerScore = _lineupScore(msg.sender);
        opponentScore = _lineupScore(opponent);
        winner = challengerScore >= opponentScore ? msg.sender : opponent;

        emit BattleResolved(msg.sender, opponent, challengerScore, opponentScore, winner);
    }

    function _lineupScore(address player) internal view returns (uint256 score) {
        uint256[3] storage ids = lineups[player].cardIds;
        for (uint256 i = 0; i < 3; i++) {
            score += cardPower(ids[i]);
        }
    }

    function _requireCard(uint256 id) internal view {
        require(bytes(templates[id].name).length != 0, "unknown card");
    }

    function _requireUniqueLineup(uint256[3] calldata cardIds) internal pure {
        require(cardIds[0] != cardIds[1] && cardIds[0] != cardIds[2] && cardIds[1] != cardIds[2], "duplicate card");
    }

    function _sameRole(string storage a, string memory b) internal view returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function _seedCards() internal {
        templates[1] = CardTemplate("Volta Finisher", "Brazil", "Striker", 88, 74, 42, 5);
        templates[2] = CardTemplate("River Plate Engine", "Argentina", "Playmaker", 76, 91, 56, 5);
        templates[3] = CardTemplate("Atlas Wall", "Morocco", "Keeper", 42, 66, 90, 4);
        templates[4] = CardTemplate("Blue Lock Runner", "Japan", "Striker", 84, 78, 48, 4);
        templates[5] = CardTemplate("Eagle Pivot", "USA", "Anchor", 72, 82, 72, 3);
        templates[6] = CardTemplate("Aztec Guardian", "Mexico", "Keeper", 40, 62, 84, 3);
        templates[7] = CardTemplate("Maple Switch", "Canada", "Playmaker", 68, 86, 54, 3);
        templates[8] = CardTemplate("Three Lions Press", "England", "Anchor", 76, 80, 78, 4);
        templates[9] = CardTemplate("La Roja Needle", "Spain", "Playmaker", 70, 92, 58, 5);
        templates[10] = CardTemplate("Oranje Breaker", "Netherlands", "Anchor", 78, 78, 82, 4);
        templates[11] = CardTemplate("Black Star Sprint", "Ghana", "Striker", 86, 70, 46, 3);
        templates[12] = CardTemplate("Samba Last Line", "Brazil", "Keeper", 38, 68, 88, 4);
    }
}
