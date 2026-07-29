export function ListofIndianPlayers({ IndianPlayers }) {
  return (
    <div>
      {IndianPlayers.map((item, index) => (
        <li key={index}>Mr. {item}</li>
      ))}
    </div>
  );
}