// THIS IS A DARKPACK UI FILE

import { useState } from 'react'; // TFN EDIT ADD
import { useBackend } from 'tgui/backend';
import { ConfirmModal } from '../components/ConfirmModal'; // TFN EDIT ADD
import {
  BlockQuote,
  Box,
  Button,
  Divider,
  Icon,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { CharacterPreview } from '../../common/CharacterPreview';
import { LoadingScreen } from '../../common/LoadingScreen';
import {
  createSetPreference,
  type Perk,
  type PreferencesMenuData,
  type ServerData,
  type Splats,
} from '../types';
import { useServerPrefs } from '../useServerPrefs';

type SplatsPerkProps = {
  className: string;
  perk: Perk;
};

function SplatsPerk(props: SplatsPerkProps) {
  const { className, perk } = props;

  return (
    <Tooltip
      position="bottom-end"
      content={
        <Box>
          <Box as="b">{perk.name}</Box>
          <Divider />
          <Box>{perk.description}</Box>
        </Box>
      }
    >
      <Box className={className} width="32px" height="32px">
        <Icon
          name={perk.ui_icon}
          size={1.5}
          ml={0}
          mt={1}
          style={{
            textAlign: 'center',
            height: '100%',
            width: '100%',
          }}
        />
      </Box>
    </Tooltip>
  );
}

type SplatsPerksProps = {
  perks: Splats['perks'];
};

function SplatsPerks(props: SplatsPerksProps) {
  const { positive, negative, neutral } = props.perks;

  return (
    <Stack fill justify="space-between">
      <Stack.Item>
        <Stack>
          {positive.map((perk) => {
            return (
              <Stack.Item key={perk.name}>
                <SplatsPerk className="color-bg-green" perk={perk} />
              </Stack.Item>
            );
          })}
        </Stack>
      </Stack.Item>

      <Stack>
        {neutral.map((perk) => {
          return (
            <Stack.Item key={perk.name}>
              <SplatsPerk className="color-bg-grey" perk={perk} />
            </Stack.Item>
          );
        })}
      </Stack>

      <Stack>
        {negative.map((perk) => {
          return (
            <Stack.Item key={perk.name}>
              <SplatsPerk className="color-bg-red" perk={perk} />
            </Stack.Item>
          );
        })}
      </Stack>
    </Stack>
  );
}

type SplatsPageInnerProps = {
  handleClose: () => void;
  splats: ServerData['splats'];
};

// TFN EDIT START
const SPLAT_WHITELIST_REQUIREMENTS: Record<string, string> = {
  none: 'human',
  splat_kindred: 'vampire',
  splat_ghoul: 'ghoul',
  splat_garou: 'garou',
  splat_kinfolk: 'kinfolk',
};
// TFN EDIT END

function SplatsPageInner(props: SplatsPageInnerProps) {
  const { act, data } = useBackend<PreferencesMenuData>();
  const setSplats = createSetPreference(act, 'splats');
  // TFN EDIT START
  const [pendingConfirm, setPendingConfirm] = useState<(() => void) | null>(null,);
  const whitelistSet = new Set(data.player_whitelists || []);
  // TFN EDIT END

  const splats: [string, Splats][] = Object.entries(props.splats).map(
    ([splats, data]) => {
      return [splats, data];
    },
  );

  // nothing choice are always the top of the list
  const noneIndex = splats.findIndex(([splats]) => splats === 'none');
  const swapWith = splats[0];
  splats[0] = splats[noneIndex];
  splats[noneIndex] = swapWith;

  const currentSplat = splats.filter(([splatsKey]) => {
    return splatsKey === data.character_preferences.misc.splats;
  })[0][1];

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Button icon="arrow-left" onClick={props.handleClose}>
          Go Back
        </Button>
      </Stack.Item>

      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <Box height="calc(100vh - 170px)" overflowY="auto" pr={3}>
              {splats.map(([splatsKey, splats]) => {
                // TFN EDIT START - my splat whitelists are too strong for you, traveller. you must go to a server with weaker whitelists
                const requiredWhitelist = SPLAT_WHITELIST_REQUIREMENTS[splatsKey];
                const isLocked = !!requiredWhitelist && !whitelistSet.has(requiredWhitelist);
                // TFN EDIT END
                return (
                  <Button
                    key={splatsKey}
                    // TFN EDIT START - warn + clear disciplines when switching splats
                    onClick={() => {
                      if ( splatsKey !== data.character_preferences.misc.splats ) {
                        setPendingConfirm(() => () => {
                          act('clear_discipline_levels');
                          setSplats(splatsKey);
                        });
                      }
                    }}
                    // TFN EDIT END
                    selected={
                      data.character_preferences.misc.splats === splatsKey
                    }
                    tooltip={ isLocked ? `${splats.name} (Whitelisted, apply for it  on Discord!)` : splats.name } // TFN EDIT ADD
                    style={{
                      display: 'block',
                      height: '64px',
                      width: '64px',
                      position: 'relative',
                    }}
                  >
                    <Box
                      className={classes(['splat64x64', splats.icon])}
                      ml={-1}
                      style={{ opacity: isLocked ? 0.4 : 1 }}
                    />
                    {/* TFN EDIT START */}
                    {isLocked && (
                      <Icon
                        name="lock"
                        style={{
                          position: 'absolute',
                          bottom: '2px',
                          right: '2px',
                          fontSize: '14px',
                          color: 'rgba(255,255,255,0.85)',
                          pointerEvents: 'none',
                        }}
                      />
                    )}
                    {/* TFN EDIT END */}
                  </Button>
                );
              })}
            </Box>
          </Stack.Item>

          <Stack.Item grow>
            <Box>
              <Box>
                <Stack fill>
                  <Stack.Item width="70%">
                    {/* TFN EDIT START */}
                    <Section title={currentSplat.name}>
                      <Section title="Description">{currentSplat.desc}</Section>
                    {/* TFN EDIT END */}

                      <Section title="Features">
                        <SplatsPerks perks={currentSplat.perks} />
                      </Section>
                    </Section>
                  </Stack.Item>

                  <Stack.Item width="30%">
                    <CharacterPreview
                      id={data.character_preview_view}
                      height="100%"
                    />
                  </Stack.Item>
                </Stack>
              </Box>

              <Box mt={1}>
                <Section title="Lore">
                  <BlockQuote>
                    {currentSplat.lore.map((text, index) => (
                      <Box key={index} maxWidth="100%">
                        {text}
                        {index !== currentSplat.lore.length - 1 && (
                          <>
                            <br />
                            <br />
                          </>
                        )}
                      </Box>
                    ))}
                  </BlockQuote>
                </Section>
              </Box>
            </Box>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      {/* TFN EDIT START - confirm dialog for splat changes */}
      {pendingConfirm !== null && (
        <ConfirmModal
          onConfirm={() => {
            pendingConfirm?.();
            setPendingConfirm(null);
          }}
          onCancel={() => setPendingConfirm(null)}
        />
      )}
      {/* TFN EDIT END */}
    </Stack>
  );
}

type SplatsPageProps = {
  closeSplats: () => void;
};

export function SplatsPage(props: SplatsPageProps) {
  const serverData = useServerPrefs();
  if (!serverData) {
    return <LoadingScreen />;
  }

  return (
    <SplatsPageInner
      handleClose={props.closeSplats}
      splats={serverData.splats}
    />
  );
}
