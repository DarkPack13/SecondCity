// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { NumberInput } from 'tgui-core/components';
import type { PreferencesMenuData } from '../../../types';
import type { FeatureNumeric, FeatureValueProps, FeatureNumericData } from '../base';

function GenerationInput(props: FeatureValueProps<number, number, FeatureNumericData>) {
  const { handleSetValue, value } = props;
  const { data } = useBackend<PreferencesMenuData>();
  const minGeneration = data.is_trusted
    ? data.max_trusted_generation
    : data.max_public_generation;

  return (
    <NumberInput
      onChange={(v) => handleSetValue(v)}
      minValue={minGeneration}
      maxValue={data.highest_generation_limit}
      step={1}
      value={value}
    />
  );
}

export const generation: FeatureNumeric = {
  name: 'Generation',
  description: 'The Generation of this Kindred.',
  component: GenerationInput,
};
