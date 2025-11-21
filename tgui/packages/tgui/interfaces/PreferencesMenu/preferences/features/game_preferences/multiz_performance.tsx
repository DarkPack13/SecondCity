import { createDropdownInput, type Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Multi-Z Depth',
  category: 'GAMEPLAY',
  description:
    'How many Multi-Z levels are rendered before they start getting culled. Decrease this to improve performance in case of lag on multi-z maps.',
  component: createDropdownInput({
    [-1]: 'No Culling',
    5: 'High', // DARKPACK EDIT CHANGE
    3: 'Medium', // DARKPACK EDIT CHANGE
    0: 'Low',
  }),
};
