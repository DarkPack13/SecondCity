// THIS IS A DARKPACK UI FILE
import { Box, Icon, Stack } from 'tgui-core/components';
import { NavigableApps } from '.';

  type SettingsChoice = {
    name: string;
    description?: string;
    icon: string;
    action: () => void;
  };

  export const ScreenSettings = (props: {
    setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
  }) => {
    const { setApp } = props;

    const choices: SettingsChoice[] = [
      {
        name: 'Backgrounds',
        description: 'Change your phone\'s background',
        icon: 'image',
        action: () => setApp(NavigableApps.Backgrounds),
      },
    ];
  return (
      <Stack vertical fill backgroundColor="#ffffff" textColor="#000">
        <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
          <Stack align="center">
            <Icon
              name="arrow-left"
              onClick={() => setApp(null)}
              style={{ cursor: 'pointer' }}
            />
            <Stack.Item grow ml={1}>Settings</Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item grow overflowY="auto">
          <Stack vertical>
            {choices.map((choice, index) => (
              <Stack.Item
                key={index}
                p={1}
                onClick={choice.action}
                className="Telephone__ContactsElement" //shameless styling copy paste from screencontacts
              >
                <Stack align="center">
                  <Stack.Item>
                    <Icon name={choice.icon} size={1.5} />
                  </Stack.Item>
                  <Stack.Item grow ml={1}>
                    <Stack vertical>
                      <Stack.Item>{choice.name}</Stack.Item>
                      {choice.description ? (
                        <Stack.Item fontSize={0.8} mt={0.5} opacity={0.7} style={{ fontStyle: 'italic' }}>
                          {choice.description}
                        </Stack.Item>
                      ) : null}
                    </Stack>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
      </Stack>
    );
  };
