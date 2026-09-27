import { CheckboxInput, type FeatureToggle } from '../base';

export const ranged_click_to_melee: FeatureToggle = {
  name: 'Distant clicks trigger melee swings',
  category: 'GAMEPLAY',
  description: `
    Clicking on a tile out of your range creates a swing or directional attack.
  `,
  component: CheckboxInput,
};
