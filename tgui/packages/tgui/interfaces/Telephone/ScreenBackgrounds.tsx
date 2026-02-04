// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { Box, Icon, Stack } from 'tgui-core/components';
import { type Data, NavigableApps } from '.';
import { backgrounds } from './backgroundImages';

export const ScreenBackgrounds = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { act } = useBackend<Data>();
  const { setApp } = props;

  const choices = [
    {
      name: 'Summer Forest',
      key: 'summerforest_b64',
    },
    {
      name: 'Forest',
      key: 'forest_b64',
    },
    {
      name: 'Beach',
      key: 'beach_b64',
    },
    {
      name: 'San Francisco Skyline',
      key: 'sfcityscape_b64',
    },
    {
      name: 'San Francisco Streets',
      key: 'sfstreet_b64',
    },
    /*
    // see backgroundImages.ts for adding backgrounds here
    {
      name: 'Example Background',
      key: 'example_key',
    },
    */
  ];

  const setBackground = (key: string) => {
    act('set_background', { background_url: key });
  };

  return (
    <Stack vertical fill backgroundColor="#fff" textColor="#000">
      <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
        <Stack align="center">
          <Icon
            name="arrow-left"
            onClick={() => setApp(null)}
            style={{ cursor: 'pointer' }}
          />
          <Stack.Item grow ml={1}>Themes</Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow overflowY="auto">
        <Stack vertical>
          {choices.map((background, index) => (
            <Stack.Item key={index}>
              <Stack
                align="center"
                p={1}
                className="Telephone__ContactsElement" //shameless styling copy paste from screencontacts
                onClick={() => setBackground(background.key)}
                style={{ cursor: 'pointer' }}
              >
                <Stack.Item>
                  <Box
                    width={4}
                    height={3}
                    style={{
                      backgroundImage: `url(${backgrounds[background.key]})`,
                      backgroundSize: 'cover',
                      backgroundPosition: 'center',
                      borderRadius: '4px',
                    }}
                  />
                </Stack.Item>
                <Stack.Item grow ml={1}>
                  <Box>{background.name}</Box>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
