import { Button, Input, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { useLocalState } from '../../backend';

import type { ATMData } from './types';

export const AtmLogin = (props) => {
  const { act, data } = useBackend<ATMData>();
  const [entered_code, setEnteredCode] = useLocalState('login_code', '');

  const { account_holder, code } = data;

  const handleLogin = () => {
    act('login', { code: entered_code });
  };
  return (
    <Section title="Please enter your code">
      <LabeledList>
        <LabeledList.Item label="code">
          <Input
            value={entered_code}
            placeholder="Enter code here"
            onInput={(e, value) => setEnteredCode(value)}
          />
        </LabeledList.Item>
        <LabeledList.Item>
          <Button content="Log In" onClick={handleLogin} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
