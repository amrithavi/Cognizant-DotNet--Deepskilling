import axios from 'axios';
import GitClient from './GitClient';

jest.mock('axios');

describe('Git Client Tests', () => {
  test('should return repository names for techiesyed', () => {
    const repos = {
      data: [
        { name: 'appscentricsolutions' },
        { name: 'ArrayListDemo' },
        { name: 'ArrayListDemo01' },
      ],
    };

    axios.get.mockResolvedValue(repos);

    return GitClient.getRepositories('techiesyed').then(response => {
      expect(response.data).toEqual(repos.data);
    });
  });
});