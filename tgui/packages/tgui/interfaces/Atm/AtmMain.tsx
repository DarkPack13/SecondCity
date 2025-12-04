import { Box, Button, Input, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { useLocalState } from '../../backend';

import type { ATMData } from './types';

export const AtmMain = (props) => {
  const { act, data } = useBackend<ATMData>();
  const [transferAmount, setTransferAmount] = useLocalState(
    'transfer_amount',
    '',
  );
  const [withdrawAmount, setWithdrawAmount] = useLocalState(
    'withdraw_amount',
    '',
  );
  const [newPin, setNewPin] = useLocalState('new_pin', '');
  const [selectedAccount, setSelectedAccount] = useLocalState(
    'selected_account',
    '',
  );
  const [searchTerm, setSearchTerm] = useLocalState('search_term', '');

  const { account_holder, atm_balance, bank_account_list = '[]' } = data;

  let accounts = [];
  try {
    accounts = JSON.parse(bank_account_list);
    if (!Array.isArray(accounts)) {
      accounts = [];
    }
  } catch (error) {
    console.error('Failed to parse bank account list', error);
  }

  accounts = accounts.sort((a, b) => {
    const nameA = (a.account_holder || '').toLowerCase();
    const nameB = (b.account_holder || '').toLowerCase();
    return nameA.localeCompare(nameB);
  });

  const filteredAccounts = accounts.filter((account) =>
    (account.account_holder || 'Unnamed Account')
      .toLowerCase()
      .includes(searchTerm.toLowerCase()),
  );

  const handleLogout = () => {
    act('logout');
  };

  const handleWithdraw = () => {
    act('withdraw', { withdraw_amount: withdrawAmount });
  };

  const handleTransfer = () => {
    act('transfer', {
      transfer_amount: transferAmount,
      target_account: selectedAccount,
    });
  };

  const handleDeposit = () => {
    act('deposit');
  };

  const handleChangePin = () => {
    act('change_pin', { new_pin: newPin });
  };

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Account Owner">
          {account_holder}
        </LabeledList.Item>
        <LabeledList.Item label="Balance">{atm_balance}</LabeledList.Item>
        <LabeledList.Item label="Money in ATM">{atm_balance}</LabeledList.Item>
      </LabeledList>
      <Box mt={2}>
        <Box className="Atm__atm-column">
          <Box className="Atm__atm-row">
            <Button
              content="Withdraw"
              onClick={handleWithdraw}
              className="Atm__atm-button"
            />
            <Input
              value={withdrawAmount}
              onInput={(e, value) => setWithdrawAmount(value)}
              placeholder="Withdraw Amount"
              style={{ flex: 3 }}
            />
          </Box>

          <Box className="Atm__atm-row">
            <Button
              onClick={handleChangePin}
              className="Atm__atm-button"
            >
              Change Pin
            </Button>
            <Input
              value={newPin}
              onInput={(e, value) => setNewPin(value)}
              placeholder="New PIN"
              style={{ flex: 3 }}
            />
          </Box>

          <Box className="Atm__atm-row">
            <Button onClick={handleDeposit} className="Atm__atm-button">
              Deposit
            </Button>
          </Box>

          <Box className="Atm__atm-row">
            <Button onClick={handleLogout} className="Atm__atm-button">
              Log Out
            </Button>
          </Box>

          <Box mt={2}>
            <Box mb={1} fontWeight="bold">
              Select Target Account
            </Box>

            <Input
              value={searchTerm}
              onInput={(e, value) => setSearchTerm(value)}
              placeholder="Search accounts"
              mb={1}
              width="100%"
            />

            <Box className="Atm__account-list">
              {filteredAccounts.length > 0 ? (
                filteredAccounts.map((account, index) => (
                  <Box
                    key={index}
                    className={`account-item ${selectedAccount === account.account_holder ? 'selected' : ''
                      }`}
                    onClick={() => setSelectedAccount(account.account_holder)}
                  >
                    {account.account_holder || 'Unnamed Account'}
                  </Box>
                ))
              ) : (
                <Box color="red" fontStyle="italic">
                  No accounts found.
                </Box>
              )}
            </Box>
          </Box>

          <Box className="Atm__atm-row">
            <Button
              content="Transfer"
              onClick={handleTransfer}
              className="Atm__atm-button"
            />
            <Input
              value={transferAmount}
              onInput={(e, value) => setTransferAmount(value)}
              placeholder="Transfer Amount"
              style={{ flex: 3 }}
            />
          </Box>
        </Box>
      </Box>
    </Section>
  );
};
