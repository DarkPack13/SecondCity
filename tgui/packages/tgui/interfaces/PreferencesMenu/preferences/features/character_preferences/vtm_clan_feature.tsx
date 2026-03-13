import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, Stack } from 'tgui-core/components';

import type { PreferencesMenuData } from '../../../types';
import {
  type FeatureChoiced,
  type FeatureValueProps,
  type FeatureToggle,
  CheckboxInput,
  FeatureExternalInput,
} from '../base';
import { FeatureIconnedDropdownInput } from '../dropdowns';

export const vampire_clan: FeatureChoiced = {
  name: 'Clan',
  component: (props: FeatureValueProps<string, string>) => {
    const { act, data } = useBackend<PreferencesMenuData>();
    const hasDisciplines = Object.values(data.discipline_levels || {}).some(
      (v) => v > 0,
    );
    const [pendingValue, setPendingValue] = useState<string | null>(null);

    const handleSetValue = (newValue: string) => {
      if (hasDisciplines && newValue !== props.value) {
        setPendingValue(newValue);
      } else {
        props.handleSetValue(newValue);
      }
    };

    return (
      <>
        <FeatureIconnedDropdownInput {...props} handleSetValue={handleSetValue} />
        {pendingValue !== null && (
          <Box
            style={{
              position: 'fixed',
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              background: 'rgba(0,0,0,0.75)',
              zIndex: 9999,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            <Box
              style={{
                background: '#1b1b1b',
                border: '1px solid #555',
                padding: '20px',
                maxWidth: '380px',
                width: '90%',
              }}
            >
              <Box bold fontSize={1.1} mb={1}>
                Change Domitor's Clan?
              </Box>
              <Box color="label" mb={2}>
                Changing your domitor's clan will wipe your existing
                discipline pool. This cannot be undone. Are you sure?
              </Box>
              <Stack justify="flex-end">
                <Stack.Item>
                  <Button onClick={() => setPendingValue(null)}>Cancel</Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    color="bad"
                    onClick={() => {
                      props.handleSetValue(pendingValue);
                      act('clear_discipline_levels');
                      setPendingValue(null);
                    }}
                  >
                    Change Clan
                  </Button>
                </Stack.Item>
              </Stack>
            </Box>
          </Box>
        )}
      </>
    );
  },
};

export const clan_mark: FeatureChoiced = {
  name: 'Marks',
  component: (
    props: FeatureValueProps<string, string>,
  ) => {
    return <FeatureExternalInput {...props} />;
  },
};

export const gargoyle_legs_and_tail: FeatureToggle = {
  name: 'Gargoyle Legs and Tail',
  component: CheckboxInput,
};
