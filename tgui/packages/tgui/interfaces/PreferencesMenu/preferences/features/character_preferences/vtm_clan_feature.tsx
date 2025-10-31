import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const clan_mark: FeatureChoiced = {
  name: 'Marks',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
