import React from 'react';

class Getuser extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      person: {},
      loading: true,
    };
  }

  async componentDidMount() {
    const url = 'https://randomuser.me/api/';
    const response = await fetch(url);
    const data = await response.json();
    this.setState({ person: data.results[0], loading: false });
    console.log(data.results[0]);
  }

  render() {
    if (this.state.loading) {
      return <h3>Loading...</h3>;
    }

    const { title, first, last } = this.state.person.name;
    const { large } = this.state.person.picture;

    return (
      <div>
        <img src={large} alt={first} />
        <h2>{title} {first} {last}</h2>
      </div>
    );
  }
}

export default Getuser;