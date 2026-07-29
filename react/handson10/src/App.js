import logo from './logo.svg';
import './App.css';
import officeSpaces from './data';

function App() {
  const element = 'Office Space';
  const jsxatt = <img src={logo} width="25%" height="25%" alt="Office Space" />;
  const ItemName = { Name: 'DBS', Rent: 50000, Address: 'Chennai' };

  return (
    <div>
      <h1>{element}, at Affordable Range</h1>
      {jsxatt}
      <h1>Name: {ItemName.Name}</h1>
      <h3>Rent: Rs. {ItemName.Rent}</h3>
      <h3>Address: {ItemName.Address}</h3>

      <hr />

      <h2>More Office Spaces</h2>
      {officeSpaces.map((item, index) => {
        let colors = [];
        if (item.Rent <= 60000) {
          colors.push('textRed');
        } else {
          colors.push('textGreen');
        }
        return (
          <div key={index}>
            <h3>Name: {item.Name}</h3>
            <h3 className={colors.join(' ')}>Rent: Rs. {item.Rent}</h3>
            <h3>Address: {item.Address}</h3>
            <hr />
          </div>
        );
      })}
    </div>
  );
}

export default App;