// THIS IS A DARKPACK UI FILE
import type { PropsWithChildren, ReactNode } from 'react';

import { useBackend } from 'tgui/backend';
import { Box, Icon, Stack } from 'tgui-core/components';

import { NavigableApps, type Data } from '.';

export const AppIcon = (
  props: PropsWithChildren<{
    size?: number;
    backgroundColor?: string;
    iconColor?: string;
    iconName?: string;
    text?: ReactNode;
    onClick?: () => void;
  }>,
) => {
  const {
    children,
    size,
    backgroundColor,
    iconColor,
    iconName,
    text,
    onClick,
  } = props;

  const actualSize = size || 2;

  return (
    <Stack vertical align="center" justify="center" onClick={onClick}>
      <Stack.Item
        style={{
          cursor: onClick ? 'pointer' : 'default',
        }}
      >
        <Box
          backgroundColor={backgroundColor}
          height={actualSize * 2}
          width={actualSize * 2}
          style={{
            borderRadius: '30%',
          }}
        >
          <Stack justify="center" align="center" fill>
            <Stack.Item>
              {iconName ? (
                <Icon name={iconName} size={actualSize} textColor={iconColor} />
              ) : null}
              {children}
            </Stack.Item>
          </Stack>
        </Box>
      </Stack.Item>
      {text ? <Stack.Item fontSize={actualSize / 2}>{text}</Stack.Item> : null}
    </Stack>
  );
};

export const IconDots = (props) => {
  return (
    <Box position="relative" ml={-2} mt={-2}>
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0}
        left={0}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0}
        left={0.75}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0}
        left={1.5}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0.75}
        left={0}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0.75}
        left={0.75}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={0.75}
        left={1.5}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={1.5}
        left={0}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={1.5}
        left={0.75}
        size={0.5}
      />
      <Icon
        name="circle"
        color="black"
        position="absolute"
        top={1.5}
        left={1.5}
        size={0.5}
      />
    </Box>
  );
};

export const ScreenHome = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { act, data } = useBackend<Data>();
  const { setApp } = props;
  const { time, date } = data;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack align="center" justify="space-between">
          <Stack.Item>
            <Box inline fontFamily="sans-serif" fontSize={4} ml={2} mt={2}>
              {time}
            </Box>
            <Box ml={2.5}>{date}</Box>
          </Stack.Item>
          <Stack.Item mr={2}>
            <Icon name="cloud" size={2} />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill align="center" justify="space-around" wrap="wrap">
          <Stack.Item>
            <AppIcon
              backgroundColor="#005555"
              text="IRC"
              //onClick={() => setApp(NavigableApps.IRC)}
            >
              <Box fontSize={1.2} bold>
                #irc
              </Box>
            </AppIcon>
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              backgroundColor="#fff"
              text="Gallery"
              iconName="file-image"
              iconColor="orange"
            />
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              backgroundColor="#fff"
              text="Camera"
              iconName="camera"
              iconColor="black"
            />
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              backgroundColor="#fff"
              text="Notes"
              iconName="file-invoice"
              iconColor="yellow"
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      {/* Screen dots */}
      <Stack.Item height={1} p={2}>
        <Stack fill align="center" justify="center">
          <Stack.Item p={1}>
            <Icon name="house" color="white" />
          </Stack.Item>
          <Stack.Item p={1}>
            <Icon name="circle" color="#ffffffa0" />
          </Stack.Item>
          <Stack.Item p={1}>
            <Icon name="circle" color="#ffffffa0" />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      {/* Bottom Bar */}
      <Stack.Item height={5} p={1} mb={7}>
        <Stack fill align="center" justify="space-around">
          <Stack.Item>
            <AppIcon
              size={1.6}
              backgroundColor="#00dd00"
              iconColor="white"
              iconName="phone"
              text="Phone"
              onClick={() => {
                setApp(NavigableApps.Phone);
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              size={1.6}
              backgroundColor="#e58e1d"
              iconColor="white"
              iconName="user"
              text="Contacts"
              onClick={() => {
                setApp(NavigableApps.Contacts);
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              size={1.6}
              backgroundColor="red"
              iconColor="white"
              iconName="comments"
              text="Message+"
              onClick={() => {
                setApp(NavigableApps.Messages);
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <AppIcon
              size={1.6}
              backgroundColor="#00f7ffff"
              text="Browser"
              iconName="globe-americas"
              iconColor="black"
              onClick={() => act('wiki')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
