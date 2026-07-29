import React from 'react';
import CurrencyConvertor from './CurrencyConvertor';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      counter: 0,
    };

    this.increment = this.increment.bind(this);
    this.decrement = this.decrement.bind(this);
    this.sayHello = this.sayHello.bind(this);
    this.sayWelcome = this.sayWelcome.bind(this);
    this.onPress = this.onPress.bind(this);
  }

  increment() {
    this.setState((prevState) => ({ counter: prevState.counter + 1 }));
    this.sayHello();
  }

  decrement() {
    this.setState((prevState) => ({ counter: prevState.counter - 1 }));
  }

  sayHello() {
    alert('Hello, counter has been incremented!');
  }

  sayWelcome(message) {
    alert(message);
  }

  onPress(event) {
    alert('I was clicked');
  }

  render() {
    return (
      <div>
        <h2>{this.state.counter}</h2>
        <button onClick={this.increment}>Increment</button>
        <button onClick={this.decrement}>Decrement</button>
        <button onClick={() => this.sayWelcome('welcome')}>Say welcome</button>
        <button onClick={this.onPress}>Click on me</button>

        <h3>Currency Convertor!!!</h3>
        <CurrencyConvertor />
      </div>
    );
  }
}

export default App;