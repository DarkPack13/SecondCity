// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { Box, Icon, Stack } from 'tgui-core/components';
import { type Data, NavigableApps } from '.';
import { backgrounds } from './backgrounds/backgroundImages';

export const ScreenBackgrounds = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { act } = useBackend<Data>();
  const { setApp } = props;

  const choices = [
    {
      name: 'Background 1',
      key: 'BG_1',
    },
    {
      name: 'Background 2',
      key: 'BG_2',
    },
    {
      name: 'Background 3',
      key: 'BG_3',
    },
    {
      name: 'Background 4',
      key: 'BG_4',
    },
    {
      name: 'Background 5',
      key: 'BG_5',
    },
    {
      name: 'Background 6',
      key: 'BG_6',
    },
    {
      name: 'Background 7',
      key: 'BG_7',
    },
    {
      name: 'Background 8',
      key: 'BG_8',
    },
    {
      name: 'Background 9',
      key: 'BG_9',
    },
    {
      name: 'Background 10',
      key: 'BG_10',
    },
    {
      name: 'Background 11',
      key: 'BG_11',
    },
    {
      name: 'Background 12',
      key: 'BG_12',
    },
    {
      name: 'Background 13',
      key: 'BG_13',
    },
    {
      name: 'Background 14',
      key: 'BG_14',
    },
    {
      name: 'Background 15',
      key: 'BG_15',
    },
    {
      name: 'Background 16',
      key: 'BG_16',
    },
    {
      name: 'Background 17',
      key: 'BG_17',
    },
    {
      name: 'Background 18',
      key: 'BG_18',
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
    setApp(null);
  };

  return (
    <Stack vertical fill backgroundColor="#ffffff" textColor="#000">
      <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
        <Stack align="center">
          <Icon
            name="arrow-left"
            onClick={() => setApp(NavigableApps.Settings)}
            style={{ cursor: 'pointer' }}
          />
          <Stack.Item grow ml={1}>Backgrounds</Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow overflowY="auto" style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}>
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
                <Stack.Item grow ml={1} mb={0.5}>
                  <Box>{background.name}</Box>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ))}
        </Stack>
        <Stack.Item mb={6} />
      </Stack.Item>
    </Stack>
  );
};
