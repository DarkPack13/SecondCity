import { useState } from 'react';

import { useBackend } from 'tgui/backend';
import { Box, Button, Icon, Input, Section, Stack, Tooltip } from 'tgui-core/components';
import { Window } from '../layouts';

type DisciplineInfo = {
  name: string;
  desc: string;
  max_level: number;
  rarity: 'rare' | 'common';
  icon_b64?: string;
};

type DisciplineValidation = {
  total: number;
  additional: number;
  additional_rare: number;
  valid: boolean;
  violations: string[];
};

type Data = {
  target_ckey: string;
  selected_slot: number;
  not_found: boolean;
  is_trusted: boolean;
  character_slots: string[];
  discipline_levels: Record<string, number>;
  clan_disciplines: string[];
  disciplines: Record<string, DisciplineInfo>;
  discipline_validation: DisciplineValidation | null;
};

type DisciplineCardProps = {
  path: string;
  discipline: DisciplineInfo;
  level: number;
  isClanDiscipline: boolean;
  isAdditional: boolean;
  onDotClick: (position: number) => void;
};

function DisciplineCard(props: DisciplineCardProps) {
  const { discipline, level, isClanDiscipline, isAdditional, onDotClick } = props;
  const isRare = discipline.rarity === 'rare';

  return (
    <Box
      style={{
        width: '25%',
        minWidth: '130px',
        padding: '6px',
        boxSizing: 'border-box',
      }}
    >
      <Section>
        <Stack vertical align="center">
          {discipline.icon_b64 && (
            <Stack.Item>
              <img
                src={`data:image/png;base64,${discipline.icon_b64}`}
                style={{ width: '96px', height: '96px', imageRendering: 'pixelated' }}
              />
            </Stack.Item>
          )}
          <Stack.Item>
            <Tooltip
              content={
                <>
                  {isClanDiscipline && (
                    <Box color="gold" textAlign="center">
                      (Clan Discipline)
                    </Box>
                  )}
                  <Box color={isRare ? 'pink' : 'label'} textAlign="center">
                    {isRare ? 'Rare Discipline' : 'Common Discipline'}
                  </Box>
                  {discipline.desc}
                </>
              }
            >
              <Box bold textAlign="center">
                {discipline.name}
                {isClanDiscipline && (
                  <Box inline color="gold" ml={0.5}>
                    <Icon name="users-rectangle" />
                  </Box>
                )}
              </Box>
            </Tooltip>
          </Stack.Item>
          <Stack.Item>
            <Box
              textAlign="center"
              fontSize="0.75em"
              color={isRare ? 'pink' : 'label'}
            >
              {isAdditional ? (isRare ? '★ Rare' : 'Common') : 'Clan'}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Stack justify="center">
              {Array.from({ length: discipline.max_level }, (_, i) => {
                const position = i + 1;
                const filled = position <= level;
                return (
                  <Stack.Item key={i}>
                    <Icon
                      name="circle"
                      color={filled ? 'white' : 'rgba(255,255,255,0.18)'}
                      onClick={() => onDotClick(position)}
                      style={{ cursor: 'pointer', fontSize: '13px', margin: '0 2px' }}
                    />
                  </Stack.Item>
                );
              })}
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
}

export function AdminDisciplineEditor() {
  const { act, data } = useBackend<Data>();
  const {
    target_ckey,
    selected_slot,
    not_found,
    is_trusted,
    character_slots,
    discipline_levels,
    clan_disciplines,
    disciplines,
    discipline_validation,
  } = data;

  const [ckeyInput, setCkeyInput] = useState('');
  const clanSet = new Set(clan_disciplines || []);
  const allDisciplines = disciplines || {};
  const levels = discipline_levels || {};

  const handleDotClick = (path: string, position: number, currentLevel: number) => {
    const newLevel = position <= currentLevel ? position - 1 : position;
    act('set_discipline_level', { discipline: path, level: newLevel });
  };

  // Only show disciplines that the character has (level > 0), all clan disciplines, plus rare/common for browsing
  const disciplineEntries = Object.entries(allDisciplines).filter(
    ([path]) => clanSet.has(path) || path in levels,
  );

  return (
    <Window title="Discipline Editor" width={900} height={700}>
      <Window.Content scrollable>
        <Box style={{ maxWidth: '600px', margin: '0 auto', paddingBottom: '8px' }}>
          <Section title="Search">
            <Stack>
              <Stack.Item grow>
                <Input
                  fluid
                  placeholder="Enter ckey..."
                  value={ckeyInput}
                  onChange={(value) => setCkeyInput(value)}
                  onEnter={() => act('search_ckey', { ckey: ckeyInput })}
                />
              </Stack.Item>
              <Stack.Item>
                <Button
                  icon="search"
                  onClick={() => act('search_ckey', { ckey: ckeyInput })}
                >
                  Search
                </Button>
              </Stack.Item>
            </Stack>
            {!!not_found && (
              <Box color="red" mt={1}>
                No player found for ckey &quot;{target_ckey}&quot;.
              </Box>
            )}
          </Section>
        </Box>
        {target_ckey && !not_found && character_slots.length > 0 && (
          <Section
            title={
              <Stack align="center">
                <Stack.Item>{target_ckey}&apos;s character slots</Stack.Item>
                <Stack.Item>
                  <Tooltip
                    content={
                      is_trusted
                        ? 'Trusted Whitelist: immune from discipline restrictions. Click to revoke.'
                        : 'Not on Trusted Whitelist: subject to discipline limits. Click to grant.'
                    }
                  >
                    <Button
                      color={is_trusted ? 'green' : 'transparent'}
                      icon={is_trusted ? 'shield-halved' : 'shield'}
                      onClick={() => act('toggle_trusted')}
                    >
                      {is_trusted ? 'Trusted' : 'Untrusted'}
                    </Button>
                  </Tooltip>
                </Stack.Item>
              </Stack>
            }
          >
            <Stack>
              {character_slots.map((name, i) => (
                <Stack.Item key={i}>
                  <Button
                    selected={selected_slot === i + 1}
                    onClick={() => act('select_slot', { slot: i + 1 })}
                  >
                    {name || `Slot ${i + 1}`}
                  </Button>
                </Stack.Item>
              ))}
            </Stack>
          </Section>
        )}
        {discipline_validation && (
          <Section>
            <Stack align="center" wrap>
              <Stack.Item>
                <Box color="label" inline>
                  Total disciplines:{' '}
                </Box>
                <Box
                  inline
                  bold
                  color={discipline_validation.total > 5 ? 'red' : 'white'}
                >
                  {discipline_validation.total} / 5
                </Box>
              </Stack.Item>
              <Stack.Item ml={2}>
                <Box color="label" inline>
                  Rare additional:{' '}
                </Box>
                <Box
                  inline
                  bold
                  color={discipline_validation.additional_rare > 2 ? 'red' : 'pink'}
                >
                  {discipline_validation.additional_rare}
                </Box>
              </Stack.Item>
              <Stack.Item ml={2}>
                {is_trusted ? (
                  <Box color="green">
                    <Icon name="shield-halved" mr={0.5} />
                    Trusted
                  </Box>
                ) : discipline_validation.valid ? (
                  <Box color="green">
                    <Icon name="check" mr={0.5} />
                    Valid
                  </Box>
                ) : (
                  <Tooltip content={discipline_validation.violations.join('\n')}>
                    <Box color="red" style={{ cursor: 'help' }}>
                      <Icon name="triangle-exclamation" mr={0.5} />
                      Invalid!
                    </Box>
                  </Tooltip>
                )}
              </Stack.Item>
            </Stack>
          </Section>
        )}
        {selected_slot > 0 && (
          <Box
            style={{
              display: 'flex',
              flexWrap: 'wrap',
              justifyContent: 'center',
              padding: '4px',
            }}
          >
            {disciplineEntries.map(([path, discipline]) => {
              const level = levels[path] ?? 0;
              return (
                <DisciplineCard
                  key={path}
                  path={path}
                  discipline={discipline}
                  level={level}
                  isClanDiscipline={clanSet.has(path)}
                  isAdditional={!clanSet.has(path)}
                  onDotClick={(position) => handleDotClick(path, position, level)}
                />
              );
            })}
          </Box>
        )}
      </Window.Content>
    </Window>
  );
}
