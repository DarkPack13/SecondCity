// THIS IS A DARKPACK UI FILE
import { Button, Stack, Tooltip } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';
import { type PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;

  const stats = data.stats;
  const static_stats = data.static_stats;
  const points = data.points;

  if (!stats || Object.keys(stats).length === 0) return null;

  // Group by category → subcategory using subtypes() order
  const grouped: Record<string, Record<string, string[]>> = {};
  Object.entries(static_stats).forEach(([path, statData]) => {
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
        <Stack fill>
          <Stack.Item grow>
            <Stack>
              {points &&
                Object.entries(points).map(([pointType, count]) => (
                  <Stack.Item key={pointType}>
                    <b>
                      {pointType.split('/').pop()}: {count}
                    </b>
                  </Stack.Item>
                ))}
            </Stack>
          </Stack.Item>
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
                    const statData = static_stats[statPath];
                    const score = stats[statPath];
                    const max = statData.max_score;
                    const label = statData.name;
                    const editable = statData.editable;
                    const filled = '●'.repeat(score);
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
