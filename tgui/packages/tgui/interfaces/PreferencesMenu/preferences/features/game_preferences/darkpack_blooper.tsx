// THIS IS A DARKPACK UI FILE
import { CheckboxInput, type FeatureToggle, FeatureSliderInput, type FeatureNumeric } from '../base';

export const blooper_hear: FeatureToggle = {
  name: 'Enable hearing vocal bloopers',
  category: 'SOUND',
  description: `When enabled, allows you to hear other character's speech sounds.`,
  component: CheckboxInput,
};

export const sound_blooper_volume: FeatureNumeric = {
  name: 'Vocal Blooper Volume',
  category: 'SOUND',
  description: 'The volume that the Vocal Barks sounds will play at.',
  component: FeatureSliderInput,
};
