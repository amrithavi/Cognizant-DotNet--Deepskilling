import React from 'react';

export class Cart extends React.Component {
  render() {
    return (
      <table>
        <tbody>
          {this.props.item.map((item, index) => {
            return (
              <tr key={index}>
                <td>{item.itemname}</td>
                <td>{item.price}</td>
              </tr>
            );
          })}
        </tbody>
      </table>
    );
  }
}