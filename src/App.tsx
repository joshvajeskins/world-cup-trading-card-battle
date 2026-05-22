import { Activity, ArrowRight, BadgeCheck, Github, RadioTower, ShieldCheck, Sparkles, Trophy } from "lucide-react";
import { useMemo, useState } from "react";
import { cards, fixture, power, type Card } from "./cards";

type EventLine = {
  type: string;
  detail: string;
};

const initialLineup = [1, 2, 3];
const rivalLineup = [4, 5, 6];

function boostFor(card: Card, resolved: boolean) {
  if (!resolved) return { attack: 0, control: 0, defense: 0 };
  if (card.role === "Striker") return { attack: fixture.stats.goals * 2 + fixture.stats.assists, control: 0, defense: 0 };
  if (card.role === "Playmaker") return { attack: 0, control: fixture.stats.assists * 2 + fixture.stats.duelsWon, defense: 0 };
  if (card.role === "Keeper") return { attack: 0, control: 0, defense: fixture.stats.saves * 2 + fixture.stats.duelsWon };
  return { attack: fixture.stats.goals, control: fixture.stats.duelsWon, defense: fixture.stats.saves };
}

function cardById(id: number) {
  return cards.find((card) => card.id === id)!;
}

export function App() {
  const [selected, setSelected] = useState<number[]>(initialLineup);
  const [resolved, setResolved] = useState(false);
  const [events, setEvents] = useState<EventLine[]>([
    { type: "RPC", detail: "X Layer testnet RPC smoke planned against chain 1952." },
    { type: "Fixture", detail: fixture.label },
  ]);

  const boosts = useMemo(() => Object.fromEntries(cards.map((card) => [card.id, boostFor(card, resolved)])), [resolved]);
  const selectedCards = selected.map(cardById);
  const rivalCards = rivalLineup.map(cardById);
  const score = selectedCards.reduce((total, card) => total + power(card, boosts), 0);
  const rivalScore = rivalCards.reduce((total, card) => total + power(card, boosts), 0);
  const winner = score >= rivalScore ? "Your lineup" : "Seeded rival";

  function toggleCard(cardId: number) {
    setSelected((current) => {
      if (current.includes(cardId)) return current.filter((id) => id !== cardId);
      if (current.length >= 3) return [current[1], current[2], cardId];
      return [...current, cardId];
    });
  }

  function runResolver() {
    setResolved(true);
    setEvents([
      { type: "FixtureResolved", detail: `Fixture ${fixture.id}: ${fixture.stats.goals} goals, ${fixture.stats.assists} assists, ${fixture.stats.saves} saves, ${fixture.stats.duelsWon} duels.` },
      { type: "CardTraitsUpgraded", detail: "Traits upgraded by role through the explicit admin resolver path." },
      { type: "BattleResolved", detail: `${winner} ${score}-${rivalScore}. Real contract emits this event in Foundry tests.` },
      ...events,
    ]);
  }

  return (
    <main>
      <section className="hero">
        <div className="field-lines" />
        <nav className="topbar liquid">
          <span>X Cup Card Battle</span>
          <div className="nav-actions">
            <a href="https://web3.okx.com/xlayer/build-x-hackathon/xcup" target="_blank" rel="noreferrer">X Cup</a>
            <a href="https://www.okx.com/web3/explorer/xlayer-test" target="_blank" rel="noreferrer">Explorer</a>
            <a href="https://github.com/joshvajeskins" target="_blank" rel="noreferrer"><Github size={16} /> Jeskins</a>
          </div>
        </nav>

        <div className="hero-grid">
          <div className="headline">
            <p className="eyebrow"><Sparkles size={16} /> GameFi + NFT on X Layer</p>
            <h1>World Cup stats that level up your squad.</h1>
            <p className="lede">
              Mint dynamic cards, submit a three-card lineup, resolve a fixture through an explicit admin resolver contract, and emit a deterministic battle result.
            </p>
            <div className="hero-actions">
              <button className="primary" onClick={runResolver} disabled={resolved || selected.length !== 3}>
                <Trophy size={18} /> {resolved ? "Battle resolved" : "Resolve fixture battle"}
              </button>
              <span className="status-pill"><RadioTower size={16} /> X Layer RPC chain 1952 proven separately</span>
            </div>
          </div>

          <aside className="judge-panel liquid">
            <div>
              <span className="panel-label">Fixture source</span>
              <strong>{fixture.title}</strong>
              <p>{fixture.label}</p>
            </div>
            <div className="stat-grid">
              <span>{fixture.stats.goals}<small>goals</small></span>
              <span>{fixture.stats.assists}<small>assists</small></span>
              <span>{fixture.stats.saves}<small>saves</small></span>
              <span>{fixture.stats.duelsWon}<small>duels</small></span>
            </div>
          </aside>
        </div>
      </section>

      <section className="battle-board">
        <div className="section-heading">
          <p className="eyebrow"><Activity size={16} /> Select exactly three</p>
          <h2>Starter card catalog</h2>
        </div>
        <div className="cards-grid">
          {cards.map((card) => {
            const selectedCard = selected.includes(card.id);
            const boost = boosts[card.id] ?? { attack: 0, control: 0, defense: 0 };
            return (
              <button key={card.id} className={`card liquid ${selectedCard ? "selected" : ""}`} onClick={() => toggleCard(card.id)} style={{ "--accent": card.color } as React.CSSProperties}>
                <span className="card-id">#{card.id.toString().padStart(2, "0")}</span>
                <span className="nation">{card.nation}</span>
                <strong>{card.name}</strong>
                <span className="role">{card.role}</span>
                <div className="metrics">
                  <span>ATK {card.attack + boost.attack}</span>
                  <span>CTL {card.control + boost.control}</span>
                  <span>DEF {card.defense + boost.defense}</span>
                </div>
              </button>
            );
          })}
        </div>
      </section>

      <section className="proof-grid">
        <div className="lineup liquid">
          <span className="panel-label">Your lineup</span>
          <h3>{selectedCards.map((card) => card.nation).join(" / ")}</h3>
          <p>{selectedCards.map((card) => card.name).join(", ")}</p>
          <strong className="score">{score}</strong>
        </div>
        <div className="lineup rival liquid">
          <span className="panel-label">Seeded rival lineup</span>
          <h3>{rivalCards.map((card) => card.nation).join(" / ")}</h3>
          <p>{rivalCards.map((card) => card.name).join(", ")}</p>
          <strong className="score">{rivalScore}</strong>
        </div>
        <div className="result liquid">
          <BadgeCheck size={22} />
          <span className="panel-label">Battle result</span>
          <h3>{resolved ? winner : "Awaiting resolver"}</h3>
          <p>{resolved ? "Contract path: FixtureResolved -> CardTraitsUpgraded -> BattleResolved." : "Run the resolver to preview the exact event sequence."}</p>
        </div>
        <div className="events liquid">
          <span className="panel-label">Proof/event rail</span>
          {events.map((event, index) => (
            <div className="event-row" key={`${event.type}-${index}`}>
              <ShieldCheck size={16} />
              <span>{event.type}</span>
              <p>{event.detail}</p>
            </div>
          ))}
        </div>
      </section>

      <footer>
        <span>No live sports feed or X Layer deployment is claimed until the matching proof is present.</span>
        <ArrowRight size={16} />
      </footer>
    </main>
  );
}
