import { CheckboxInput, type FeatureToggle } from '../base';

export const swing_combat: FeatureToggle = {
  name: 'Use swing combat',
  category: 'GAMEPLAY',
  description: `
    Do you want melee items to swing for combat?
  `,
  component: CheckboxInput,
};
