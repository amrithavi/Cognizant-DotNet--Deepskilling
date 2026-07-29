import { mount, shallow } from 'enzyme';
import CohortDetails from './CohortDetails';
import { CohortsData } from './Cohort';

describe('Cohort Details Component', () => {
  test('should create the component', () => {
    const wrapper = shallow(<CohortDetails cohort={CohortsData[0]} />);
    expect(wrapper.exists()).toBe(true);
  });

  test('should initialize the props', () => {
    const wrapper = mount(<CohortDetails cohort={CohortsData[0]} />);
    expect(wrapper.props().cohort).toEqual(CohortsData[0]);
  });

  test('should display cohort code in h3', () => {
    const wrapper = mount(<CohortDetails cohort={CohortsData[0]} />);
    expect(wrapper.find('h3').text()).toContain(CohortsData[0].cohortCode);
  });

  test('should always render same html', () => {
    const wrapper = shallow(<CohortDetails cohort={CohortsData[0]} />);
    expect(wrapper).toMatchSnapshot();
  });
});