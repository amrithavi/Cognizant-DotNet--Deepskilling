import { render, screen } from '@testing-library/react';
import App from './App';

test('renders the git repositories heading', () => {
  render(<App />);
  const headingElement = screen.getByText(/Git repositories of User/i);
  expect(headingElement).toBeInTheDocument();
});