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

export const gargoyle_legs_and_tail: FeatureChoiced = {
  name: 'Gargoyle Legs and Tail',
  component: (
    props: FeatureValueProps<string, string>,
  ) => {
    return <FeatureExternalInput {...props} />;
  },
};
