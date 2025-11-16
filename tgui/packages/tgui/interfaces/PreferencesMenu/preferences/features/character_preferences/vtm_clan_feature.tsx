import {
  type FeatureChoiced,
  type FeatureValueProps,
  FeatureExternalInput,
} from '../base';

export const clan_mark: FeatureChoiced = {
  name: 'Marks',
  component: (
    props: FeatureValueProps<string, string>,
  ) => {
    return <FeatureExternalInput {...props} />;
  },
};
