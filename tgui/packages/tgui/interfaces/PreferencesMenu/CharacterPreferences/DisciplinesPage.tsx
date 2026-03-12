// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { Box, Button, Collapsible, Icon, Section, Stack, Tooltip } from 'tgui-core/components';

import { LoadingScreen } from '../../common/LoadingScreen';
import type { DisciplineInfo, PreferencesMenuData } from '../types';
import type { ServerData } from '../types';
import { useServerPrefs } from '../useServerPrefs';

type DisciplinesPageProps = {
  goBack: () => void;
};

type DisciplineCardProps = {
  discipline: DisciplineInfo;
  level: number;
  pointsAvailable: number;
  pointsSpent: number;
  onDotClick: (position: number) => void;
};

function DisciplineCard(props: DisciplineCardProps) {
  const { discipline, level, pointsAvailable, pointsSpent, onDotClick } = props;
  const pointsRemaining = pointsAvailable - pointsSpent;

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
              <Box
                style={{
                  display: 'inline-block',
                  lineHeight: '0',
                }}
              >
                <img
                  src={`data:image/png;base64,${discipline.icon_b64}`}
                  style={{ width: '96px', height: '96px', imageRendering: 'pixelated' }}
                />
              </Box>
            </Stack.Item>
          )}
          <Stack.Item>
            <Tooltip content={discipline.desc}>
              <Box bold textAlign="center">
                {discipline.name}
              </Box>
            </Tooltip>
          </Stack.Item>
          <Stack.Item>
            <Stack justify="center">
              {Array.from({ length: discipline.max_level }, (_, i) => {
                const position = i + 1;
                const filled = position <= level;
                const wouldIncrease = position > level;
                const canAfford = pointsRemaining >= position - level;
                const clickable = filled || canAfford;
                return (
                  <Stack.Item key={i}>
                    <Icon
                      name="circle"
                      color={filled ? 'white' : wouldIncrease && !canAfford ? 'rgba(255,255,255,0.07)' : 'rgba(255,255,255,0.18)'}
                      onClick={clickable ? () => onDotClick(position) : undefined}
                      style={{
                        cursor: clickable ? 'pointer' : 'not-allowed',
                        fontSize: '13px',
                        margin: '0 2px',
                      }}
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

type DisciplinesInnerProps = {
  goBack: () => void;
  disciplines: ServerData['disciplines'];
};

function DisciplinesInner(props: DisciplinesInnerProps) {
  const { goBack, disciplines } = props;
  const { act, data } = useBackend<PreferencesMenuData>();
  const disciplineLevels = data.discipline_levels || {};
  const clanDisciplines = new Set(data.clan_disciplines || []);
  const pointsAvailable = data.discipline_points_available ?? 12;
  const pointsSpent = data.discipline_points_spent ?? 0;
  const tier = data.discipline_tier ?? 'Fledgling';
  const tierDetails = data.discipline_tier_details ?? '';
  const pointsRemaining = pointsAvailable - pointsSpent;
  const overBudget = pointsSpent > pointsAvailable;

  const handleDotClick = (path: string, position: number, currentLevel: number) => {
    const newLevel = position <= currentLevel ? position - 1 : position;
    act('set_discipline_level', { discipline: path, level: newLevel });
  };
  const disciplineEntries = Object.entries(disciplines).filter(
    ([path]) => clanDisciplines.has(path) || path in disciplineLevels,
  );

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack align="center">
          <Stack.Item>
            <Button icon="arrow-left" onClick={goBack}>
              Back
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Stack vertical align="center">
              <Stack.Item>
                <Box fontSize={1.5} bold textAlign="center">
                  Disciplines
                </Box>
              </Stack.Item>
              <Stack.Item>
                <Stack justify="center">
                  {Array.from({ length: pointsAvailable }, (_, i) => {
                    const filled = i < pointsRemaining;
                    return (
                      <Stack.Item key={i}>
                        <Icon
                          name="circle"
                          color={filled ? (overBudget ? 'red' : 'white') : 'rgba(255,255,255,0.18)'}
                          style={{ fontSize: '10px', margin: '0 1px' }}
                        />
                      </Stack.Item>
                    );
                  })}
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item style={{ visibility: 'hidden' }}>
            <Button icon="arrow-left">Back</Button>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Box color="label" textAlign="center">
          {pointsRemaining >= 0 ? pointsRemaining : 0} / {pointsAvailable} dots remaining
        </Box>
      </Stack.Item>
      <Stack.Item>
        <Box color="label" textAlign="center">
          <i>A kindred's immortal age determines their dot balance. The higher their age, the more dots they can assign.</i>
        </Box>
      </Stack.Item>
      {tierDetails && (
        <Stack.Item>
          <Section>
            <Collapsible title={`The ${tier}`} open={true} icon={"info"}>
              {tierDetails.split('\n\n').map((paragraph, i) => (
                <Box key={i} mb={i < tierDetails.split('\n\n').length - 1 ? 1 : 0}>
                  {paragraph}
                </Box>
              ))}
            </Collapsible>
          </Section>
        </Stack.Item>
      )}
      <Stack.Divider />
      <Stack.Item grow overflowY="auto">
        <Box
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            justifyContent: 'center',
            padding: '8px',
          }}
        >
          {disciplineEntries.map(([path, discipline]) => {
            const level = disciplineLevels[path] ?? 0;
            return (
              <DisciplineCard
                key={path}
                discipline={discipline}
                level={level}
                pointsAvailable={pointsAvailable}
                pointsSpent={pointsSpent}
                onDotClick={(position) => handleDotClick(path, position, level)}
              />
            );
          })}
        </Box>
      </Stack.Item>
    </Stack>
  );
}

export function DisciplinesPage(props: DisciplinesPageProps) {
  const serverData = useServerPrefs();

  if (!serverData) {
    return <LoadingScreen />;
  }

  return (
    <DisciplinesInner
      goBack={props.goBack}
      disciplines={serverData.disciplines || {}}
    />
  );
}
