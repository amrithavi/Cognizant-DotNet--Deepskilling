export function ScoreBelow70({ players }) {
  const filteredPlayers = players.filter((item) => item.score <= 70);

  return (
    <div>
      {filteredPlayers.map((item, index) => (
        <div key={index}>
          <li>Mr. {item.name} <span>{item.score}</span></li>
        </div>
      ))}
    </div>
  );
}