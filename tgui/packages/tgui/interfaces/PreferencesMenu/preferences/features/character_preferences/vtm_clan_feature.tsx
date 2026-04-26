import {
  CheckboxInput,
  type FeatureChoiced,
  FeatureExternalInput,
  type FeatureToggle,
  type FeatureValueProps,
} from '../base';
/* TFN REMOVAL START
// vampire_clan is exported from tfn_trusted_whitelist.tsx now to add lock icons for whitelisted clans, so this is commented out
import { FeatureIconnedDropdownInput } from '../dropdowns';

export const vampire_clan: FeatureChoiced = {
  name: 'Clan',
  component: (props: FeatureValueProps<string, string>) => {
    return <FeatureIconnedDropdownInput {...props} />;
  },
};

*/ // TFN REMOVAL END
export const clan_mark: FeatureChoiced = {
  name: 'Marks',
  component: (props: FeatureValueProps<string, string>) => {
    return <FeatureExternalInput {...props} />;
  },
};

export const gargoyle_legs_and_tail: FeatureToggle = {
  name: 'Gargoyle Legs and Tail',
  component: CheckboxInput,
};
