import { CheckboxInput, type FeatureToggle } from '../base';

export const show_flavor_text_when_masked: FeatureToggle = {
  name: 'Show Identity When Masked',
  description: 'Show identity and flavor text while your face is hidden.',
  component: CheckboxInput,
};
