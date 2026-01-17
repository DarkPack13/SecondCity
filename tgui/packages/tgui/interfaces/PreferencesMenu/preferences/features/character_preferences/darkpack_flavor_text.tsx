// THIS IS A DARKPACK UI FILE
import {
  type Feature,
  FeatureTextInput,
} from '../base';

export const flavor_text: Feature<string> = {
  name: 'Flavor Text',
  description: "Appears when your character is examined (but only if they're identifiable - try a gas mask).",
  component: FeatureTextInput,
};

export const nsfw_flavor_text: Feature<string> = {
  name: 'NSFW Flavor Text',
  description: "Appears when your character is examined (but only if they're identifiable - try a gas mask).",
  component: FeatureTextInput,
};

export const character_notes: Feature<string> = {
  name: 'Character Notes',
  description:
    'OOC information about your character specifically! Like if you want a human ghouled or embraced.',
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: 'OOC Notes (NSFW))',
  description: 'Anything you want other players to know about you goes here, such as antag information, OOC triggers, etc.',
  component: FeatureTextInput,
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const criminal_record: Feature<string> = {
  name: 'Criminal Records',
  description: 'Viewable with security access. For criminal records, arrest history, things like that.',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: 'Medical Records',
  description: 'Viewable with medical access. For things like medical history, prescriptions, DNR orders, etc.',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Exploitable Records',
  description:
    'Can be IC or OOC. Viewable by certain antagonists, as well as ghosts. Generally contains \
  things like weaknesses, strengths, important background, trigger words, etc. It ALSO may contain things like \
  antagonist preferences, e.g. if you want to be antagonized, by whom, with what, etc.',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: 'Background Records',
  description: 'Only viewable by yourself and ghosts. You can have whatever you want in here - it may be valuable as a way to orient yourself to what your character is.',
  component: FeatureTextInput,
};
