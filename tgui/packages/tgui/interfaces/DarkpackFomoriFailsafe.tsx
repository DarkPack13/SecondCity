import { Button, NoticeBox, Section, Stack, Table } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type FomorInfoList = {
  name: string;
  location: string;
  status: string;
  boom: BooleanLike;
  dna: string;
  armed: BooleanLike;
};

type Data = {
  fomor_list: FomorInfoList[];
};

export const DarkpackFomoriFailsafe = (props) => {
  return (
    <NtosWindow width={400} height={500}>
      <NtosWindow.Content scrollable>
        <NtosFomorFailsafeContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosFomorFailsafeContent = (props) => {
  const { act, data } = useBackend<Data>();
  const { fomor_list = [] } = data;
  return (
    <>
      <NoticeBox>
        Scan any fomor to be notified when it receives a message.
      </NoticeBox>
      {!!fomor_list.length && (
        <Section>
          <Table>
            <Table.Row header>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Location</Table.Cell>
              <Table.Cell>Status</Table.Cell>
              <Table.Cell />
            </Table.Row>
            {fomor_list.map((fomor) => (
              <Table.Row className="candystripe" key={fomor.name}>
                <Table.Cell py={1} verticalAlign="middle">
                  {fomor.name}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle">
                  {fomor.location}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle">
                  {fomor.status}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle" collapsing>
                  <Stack>
                    <Button.Confirm
                      fluid
                      icon={fomor.armed ? 'fa-explosion' : 'bomb'}
                      color={fomor.armed ? 'red' : 'default'}
                      tooltip="Detonate"
                      confirmColor="red"
                      confirmContent="Confirm Detonation?"
                      confirmIcon="fa-explosion"
                      onClick={() => act('boom', { dna: fomor.dna })}
                    />
                    {fomor.armed ? 'ARMED' : ''}
                  </Stack>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      )}
    </>
  );
};
