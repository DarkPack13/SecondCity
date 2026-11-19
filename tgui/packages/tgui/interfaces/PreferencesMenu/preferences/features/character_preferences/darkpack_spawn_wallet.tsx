// THIS IS A DARKPACK FILE
import { CheckboxInput, type FeatureToggle } from '../base';

export const spawn_without_wallet: FeatureToggle = {
  name: 'Spawn without Wallet',
  description:
    'If checked, your character will not spawn with a wallet to hold relevant job items. Those items will be quick equipped if possible.',
  component: CheckboxInput,
};
