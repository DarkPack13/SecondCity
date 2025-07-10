import { CheckboxInput, FeatureToggle } from '../base';

export const chat_roll_info: FeatureToggle = {
  name: 'See dice rolls',
  category: 'CHAT',
  description: "Shows storyteller rolls in chat.",
  component: CheckboxInput,
};
