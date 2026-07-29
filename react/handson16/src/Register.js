import React from 'react';

class Register extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      fullName: '',
      email: '',
      password: '',
      errors: {
        fullName: '',
        email: '',
        password: '',
      },
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange = (event) => {
    event.preventDefault();
    const { name, value } = event.target;
    let errors = this.state.errors;

    switch (name) {
      case 'fullName':
        errors.fullName =
          value.length < 5 ? 'Full Name must be 5 characters long!' : '';
        break;
      case 'email':
        const validEmailRegex = RegExp(
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        );
        errors.email = validEmailRegex.test(value) ? '' : 'Email is not valid!';
        break;
      case 'password':
        errors.password =
          value.length < 8 ? 'Password must be 8 characters long!' : '';
        break;
      default:
        break;
    }

    this.setState({ errors, [name]: value });
  };

  validateForm = (errors) => {
    let valid = true;
    Object.values(errors).forEach((val) => val.length > 0 && (valid = false));
    return valid;
  };

  handleSubmit = (event) => {
    event.preventDefault();
    if (this.validateForm(this.state.errors)) {
      alert('Valid Form');
    } else {
      if (this.state.errors.fullName !== '') {
        alert(this.state.errors.fullName);
      }
      if (this.state.errors.email !== '') {
        alert(this.state.errors.email);
      }
      if (this.state.errors.password !== '') {
        alert(this.state.errors.password);
      }
    }
  };

  render() {
    return (
      <div>
        <h2>Register Here!!!</h2>
        <form onSubmit={this.handleSubmit}>
          <label>
            Name:
            <input type="text" name="fullName" onChange={this.handleChange} />
          </label>
          <br />
          <label>
            Email:
            <input type="text" name="email" onChange={this.handleChange} />
          </label>
          <br />
          <label>
            Password:
            <input type="password" name="password" onChange={this.handleChange} />
          </label>
          <br />
          <button type="submit">Submit</button>
        </form>
      </div>
    );
  }
}

export default Register;