// THIS IS A DARKPACK UI FILE
import { Button, Stack, Tooltip, AnimatedNumber, Section } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';
import type {  PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;

  const stats = data.stats;

  if (!stats || Object.keys(stats).length === 0) return null;

  const pointStats = Object.entries(stats)
    .filter(([path, statData]) => path === statData.abstract_type && statData.name)
    .map(([path, statData]) => ({
      path,
      name: statData.name, // Display name for the points stat
      points: statData.points, // The current point value
    }));

  // Group by category → subcategory using subtypes() order
  const grouped: Record<string, Record<string, string[]>> = {};
  Object.entries(stats).forEach(([path, statData]) => {
    if (path === statData.abstract_type) return;
    const category = statData.category;
    const subcategory = statData.subcategory ?? 'General';
    if (!grouped[category]) grouped[category] = {};
    if (!grouped[category][subcategory]) grouped[category][subcategory] = [];
    grouped[category][subcategory].push(path);
  });

  return (
    <Stack vertical fill className="PreferencesMenu__Stats">
      {/* Header row */}
      <Stack.Item className="PreferencesMenu__Stats__header">
        <Stack>
          <Stack.Item>
            <Button
              className="reset-button"
              icon="trash"
              onClick={() => act('reset_stats')}
              color="red"
              tooltip="Reset Stats"
              tooltipPosition="top"
            />
          </Stack.Item>
          <Stack.Item>
          {pointStats.map((pointStat) => (
            <Section inline my='10px' mx='5px' key={pointStat.path}>
              <Stack.Item inline my='10px' mx='5px' key={pointStat.path}>
              <b>{pointStat.name}: </b>
              <AnimatedNumber value={pointStat.points} />
              </Stack.Item>
            </Section>
          ))}
          </Stack.Item>
        </Stack>
      </Stack.Item>

      {/* Categories */}
      {Object.entries(grouped).map(([category, subcats]) => (
        <Stack.Item key={category} className="PreferencesMenu__Stats__category">
          <b>{category}</b>
          <Stack>
            {/* Subcategories */}
            {Object.entries(subcats).map(([subcat, paths]) => (
              <Stack.Item
                key={subcat}
                className="PreferencesMenu__Stats__category__subcategory"
              >
                <i>{subcat}</i>
                <Stack vertical>
                  {paths.map((statPath) => {
                    const statData = stats[statPath];
                    const score = statData.score;
                    const bonus_score = statData.bonus_score
                    const max = statData.max_score;
                    const label = statData.name;
                    const editable = statData.editable;
                    const filled = '●'.repeat(score + bonus_score);
                    const empty = '○'.repeat(max - score);

                    return (
                      <Stack.Item key={statPath} className="stat">
                        <Stack fill>
                          <Stack.Item grow basis="50%" className="stat-label">
                            <Tooltip content={statData.desc}>{label}</Tooltip>
                          </Stack.Item>
                          <Stack.Item grow basis="50%" textAlign="right">
                            <Stack fill g={1}>
                              {editable === 1 && (
                                <>
                                  <Stack.Item>
                                    <Button
                                      icon="minus"
                                      disabled={score <= 0}
                                      onClick={() =>
                                        act('decrease_stat', { stat: statPath })
                                      }
                                    />
                                  </Stack.Item>
                                  <Stack.Item>
                                    <Button
                                      icon="plus"
                                      disabled={score >= max}
                                      onClick={() =>
                                        act('increase_stat', { stat: statPath })
                                      }
                                    />
                                  </Stack.Item>
                                </>
                              )}
                              <Stack.Item className="stat-dots">
                                <span className="filled">{filled}</span>
                                <span className="empty">{empty}</span>
                              </Stack.Item>
                            </Stack>
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    );
                  })}
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
      ))}
    </Stack>
  );
}
