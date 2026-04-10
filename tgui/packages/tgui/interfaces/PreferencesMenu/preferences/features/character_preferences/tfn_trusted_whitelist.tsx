import type { FeatureChoiced, FeatureValueProps } from '../base';
import { FeatureIconnedDropdownInput } from '../dropdowns';
import { useBackend } from 'tgui/backend';
import type { PreferencesMenuData } from '../../../types';

// the string names of the clans in trusted_whitelist.dm
const TRUSTED_ONLY_CLAN_NAMES = ['Baali', 'Salubri', 'Healer Salubri', 'Warrior Salubri', 'True Brujah', 'Daughters of Cacophony', 'Samedi'];

type ClanServerData = {
  choices: string[];
  icons: Record<string, string>;
  name?: string;
};

export const vampire_clan: FeatureChoiced = {
  name: 'Clan',
  component: (props: FeatureValueProps<string, string, ClanServerData>) => {
    const { data } = useBackend<PreferencesMenuData>();
    const isTrusted = !!data.discipline_trusted;

    if (isTrusted || !props.serverData) {
      return <FeatureIconnedDropdownInput {...props} />;
    }

    const filteredChoices = props.serverData.choices.filter(
      (c) => !TRUSTED_ONLY_CLAN_NAMES.includes(c),
    );
    const filteredIcons = Object.fromEntries(
      Object.entries(props.serverData.icons ?? {}).filter(
        ([k]) => !TRUSTED_ONLY_CLAN_NAMES.includes(k),
      ),
    );

    const filteredServerData = {
      ...props.serverData,
      choices: filteredChoices,
      icons: filteredIcons,
    };

    return <FeatureIconnedDropdownInput {...props} serverData={filteredServerData} />;
  },
};
