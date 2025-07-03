import { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const vtm_morality_path: FeatureChoiced = {
  name: 'Path',
  description: 'The morality the character subscribes to.',
  component: FeatureDropdownInput,
};
