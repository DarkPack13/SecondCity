import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const adjective_preference: FeatureChoiced = {
  name: 'Adjective',
  description: 'In one word, how would you describe your character\'s appereance?',
  component: FeatureDropdownInput,
};
