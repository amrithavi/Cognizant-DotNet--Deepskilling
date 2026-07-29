import React from 'react';

class ComplaintRegister extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      ename: '',
      complaint: '',
      NumberHolder: Math.floor(100000 + Math.random() * 900000),
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    var msg =
      'Thanks ' + this.state.ename + ' \n Your Complaint was Submitted. Reference ID is: ' + this.state.NumberHolder;
    alert(msg);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Employee Name:
          <input type="text" name="ename" value={this.state.ename} onChange={this.handleChange} />
        </label>
        <br />
        <label>
          Complaint:
          <textarea name="complaint" value={this.state.complaint} onChange={this.handleChange} />
        </label>
        <br />
        <button type="submit">Submit</button>
      </form>
    );
  }
}

export default ComplaintRegister;