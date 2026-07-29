import players from './players';
import IndianTeam from './IndianTeam';
import { ListofPlayers } from './ListofPlayers';
import { ScoreBelow70 } from './ScoreBelow70';
import { OddPlayers, EvenPlayers } from './OddEvenPlayers';
import { IndianPlayers } from './IndianPlayers';
import { ListofIndianPlayers } from './ListofIndianPlayers';

function App() {
  var flag = true;

  if (flag === true) {
    return (
      <div>
        <h1>List of Players</h1>
        <ListofPlayers players={players} />
        <hr />
        <h1>List of Players having Scores Less than 70</h1>
        <ScoreBelow70 players={players} />
      </div>
    );
  } else {
    return (
      <div>
        <div>
          <h1>Indian Team</h1>
          <h1>Odd Players</h1>
          {OddPlayers(IndianTeam)}
          <hr />
          <h1>Even Players</h1>
          {EvenPlayers(IndianTeam)}
        </div>
        <hr />
        <div>
          <h1>List of Indian Players Merged:</h1>
          <ListofIndianPlayers IndianPlayers={IndianPlayers} />
        </div>
      </div>
    );
  }
}

export default App;