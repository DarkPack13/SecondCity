import { CheckboxInput, type FeatureToggle } from '../base';

export const show_flavor_text_when_masked: FeatureToggle = {
  name: 'Show Identity When Masked',
  description:
    'Show your name to those who know you and flavor text while your face is hidden.',
  component: CheckboxInput,
};
