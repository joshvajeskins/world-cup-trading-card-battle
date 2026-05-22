export type CardRole = "Striker" | "Playmaker" | "Keeper" | "Anchor";

export type Card = {
  id: number;
  name: string;
  nation: string;
  role: CardRole;
  attack: number;
  control: number;
  defense: number;
  rarity: number;
  color: string;
};

export const cards: Card[] = [
  { id: 1, name: "Volta Finisher", nation: "Brazil", role: "Striker", attack: 88, control: 74, defense: 42, rarity: 5, color: "#f3df36" },
  { id: 2, name: "River Plate Engine", nation: "Argentina", role: "Playmaker", attack: 76, control: 91, defense: 56, rarity: 5, color: "#78d9ff" },
  { id: 3, name: "Atlas Wall", nation: "Morocco", role: "Keeper", attack: 42, control: 66, defense: 90, rarity: 4, color: "#d3182a" },
  { id: 4, name: "Blue Lock Runner", nation: "Japan", role: "Striker", attack: 84, control: 78, defense: 48, rarity: 4, color: "#315be8" },
  { id: 5, name: "Eagle Pivot", nation: "USA", role: "Anchor", attack: 72, control: 82, defense: 72, rarity: 3, color: "#f34c4c" },
  { id: 6, name: "Aztec Guardian", nation: "Mexico", role: "Keeper", attack: 40, control: 62, defense: 84, rarity: 3, color: "#19a862" },
  { id: 7, name: "Maple Switch", nation: "Canada", role: "Playmaker", attack: 68, control: 86, defense: 54, rarity: 3, color: "#f42f3f" },
  { id: 8, name: "Three Lions Press", nation: "England", role: "Anchor", attack: 76, control: 80, defense: 78, rarity: 4, color: "#f1f3ff" },
  { id: 9, name: "La Roja Needle", nation: "Spain", role: "Playmaker", attack: 70, control: 92, defense: 58, rarity: 5, color: "#ffb23e" },
  { id: 10, name: "Oranje Breaker", nation: "Netherlands", role: "Anchor", attack: 78, control: 78, defense: 82, rarity: 4, color: "#ff7a1a" },
  { id: 11, name: "Black Star Sprint", nation: "Ghana", role: "Striker", attack: 86, control: 70, defense: 46, rarity: 3, color: "#12b76a" },
  { id: 12, name: "Samba Last Line", nation: "Brazil", role: "Keeper", attack: 38, control: 68, defense: 88, rarity: 4, color: "#2edb71" },
];

export const fixture = {
  id: 1001,
  title: "Brazil v Japan demo fixture",
  label: "Admin resolver demo fixture - not live sports API",
  stats: { goals: 3, assists: 2, saves: 5, duelsWon: 11 },
};

export function power(card: Card, boosts: Record<number, { attack: number; control: number; defense: number }>) {
  const boost = boosts[card.id] ?? { attack: 0, control: 0, defense: 0 };
  return card.attack + boost.attack + card.control + boost.control + card.defense + boost.defense;
}
