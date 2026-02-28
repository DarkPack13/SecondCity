// THIS IS A DARKPACK UI FILE
import { FeatureNumeric, FeatureValueProps, FeatureNumericData, FeatureNumberInput } from '../base';
import { Stack, Box } from 'tgui-core/components';

type HeightServerData = FeatureNumericData & {
  height_labels: Record<string, string>;
};

function HeightInput(props: FeatureValueProps<number, number, HeightServerData>) {
  return (
    <Stack align="center">
      <Stack.Item>
        <FeatureNumberInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Box>{props.serverData?.height_labels[props.value]}</Box>
      </Stack.Item>
    </Stack>
  );
}

export const height: FeatureNumeric = {
  name: 'Height',
  description: 'The height of your character.',
  component: HeightInput,
};
