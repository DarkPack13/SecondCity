import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const stat_spreads_attribute: FeatureChoiced = {
  name: 'Attribute Spread',
  component: FeatureDropdownInput,
};

export const stat_spreads_ability: FeatureChoiced = {
  name: 'Ability Spread',
  component: FeatureDropdownInput,
};
