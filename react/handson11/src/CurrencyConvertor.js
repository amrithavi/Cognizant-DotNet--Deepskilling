import React from 'react';

class CurrencyConvertor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      amount: '',
      currency: 'EUR',
    };

    this.handleAmountChange = this.handleAmountChange.bind(this);
    this.handleCurrencyChange = this.handleCurrencyChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleAmountChange(event) {
    this.setState({ amount: event.target.value });
  }

  handleCurrencyChange(event) {
    this.setState({ currency: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    const rate = 0.8; // conversion factor, see note below
    const converted = (this.state.amount * rate).toFixed(2);
    alert(`Converting to ${this.state.currency} amount is ${converted}`);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Amount:
          <input type="number" value={this.state.amount} onChange={this.handleAmountChange} />
        </label>
        <br />
        <label>
          Currency:
          <input type="text" value={this.state.currency} onChange={this.handleCurrencyChange} />
        </label>
        <br />
        <button type="submit">Submit</button>
      </form>
    );
  }
}

export default CurrencyConvertor;