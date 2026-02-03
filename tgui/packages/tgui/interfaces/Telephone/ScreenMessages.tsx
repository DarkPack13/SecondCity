// THIS IS A DARKPACK UI FILE
import { useState } from 'react';
import { Box, Icon, Stack, Tooltip } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { type Contact, type Data, NavigableApps } from '.';
import { ContactElement } from './ScreenContacts';

export const Keyboard = (props: { onClick?: (keyPressed: string) => void }) => {
  const { onClick } = props;
  const [caps, setCaps] = useState(false);

  const keyHandler = (key: string) => {
    if (onClick) {
      onClick(key);
    }
  };

  return (
    <Stack vertical fill backgroundColor="#aed7ff" pt={1} pb={1}>
      <Stack.Item>
        <Stack align="center" justify="center">
          {['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].map(
            (numberKey) => (
              <Stack.Item
                key={numberKey}
                onClick={() => keyHandler(numberKey)}
                style={{ cursor: 'pointer' }}
              >
                <Box
                  inline
                  width={1.8}
                  height={2}
                  backgroundColor="#beecff"
                  textColor="#000"
                  fontSize={1.2}
                  style={{
                    borderRadius: '4px',
                  }}
                >
                  <Stack fill align="center" justify="center">
                    <Stack.Item>{numberKey}</Stack.Item>
                  </Stack>
                </Box>
              </Stack.Item>
            ),
          )}
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill align="center" justify="center">
          {['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'].map((key) => {
            if (!caps) {
              key = key.toLowerCase();
            }
            return (
              <Stack.Item
                key={key}
                onClick={() => keyHandler(key)}
                style={{ cursor: 'pointer' }}
              >
                <Box
                  inline
                  width={1.8}
                  height={2.4}
                  backgroundColor="#d5ffff"
                  textColor="#000"
                  fontSize={1.2}
                  style={{
                    borderRadius: '4px',
                  }}
                >
                  <Stack fill align="center" justify="center">
                    <Stack.Item>{key}</Stack.Item>
                  </Stack>
                </Box>
              </Stack.Item>
            );
          })}
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill align="center" justify="center">
          {['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'].map((key) => {
            if (!caps) {
              key = key.toLowerCase();
            }
            return (
              <Stack.Item
                key={key}
                onClick={() => keyHandler(key)}
                style={{ cursor: 'pointer' }}
              >
                <Box
                  inline
                  width={1.8}
                  height={2.4}
                  backgroundColor="#d5ffff"
                  textColor="#000"
                  fontSize={1.2}
                  style={{
                    borderRadius: '4px',
                  }}
                >
                  <Stack fill align="center" justify="center">
                    <Stack.Item>{key}</Stack.Item>
                  </Stack>
                </Box>
              </Stack.Item>
            );
          })}
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill align="center" justify="center">
          <Stack.Item>
            <Box
              inline
              width={3}
              height={2.4}
              backgroundColor="#beecff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
                cursor: 'pointer',
              }}
              onClick={() => setCaps((x) => !x)}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>
                  <Icon name="arrow-up" color={caps ? 'blue' : 'black'} />
                </Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
          {['Z', 'X', 'C', 'V', 'B', 'N', 'M'].map((key) => {
            if (!caps) {
              key = key.toLowerCase();
            }
            return (
              <Stack.Item
                key={key}
                onClick={() => keyHandler(key)}
                style={{ cursor: 'pointer' }}
              >
                <Box
                  inline
                  width={1.8}
                  height={2.4}
                  backgroundColor="#d5ffff"
                  textColor="#000"
                  fontSize={1.2}
                  style={{
                    borderRadius: '4px',
                  }}
                >
                  <Stack fill align="center" justify="center">
                    <Stack.Item>{key}</Stack.Item>
                  </Stack>
                </Box>
              </Stack.Item>
            );
          })}
          <Stack.Item
            style={{ cursor: 'pointer' }}
            onClick={() => keyHandler('Backspace')}
          >
            <Box
              inline
              width={3}
              height={2.4}
              backgroundColor="#beecff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>
                  <Icon name="delete-left" />
                </Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill align="center" justify="center">
          <Stack.Item>
            <Box
              inline
              width={3}
              height={2.4}
              backgroundColor="#beecff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>?123</Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box
              inline
              width={1.8}
              height={2.4}
              backgroundColor="#d5ffff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>
                  <Icon name="microphone" />
                </Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
          <Stack.Item
            style={{ cursor: 'pointer' }}
            onClick={() => keyHandler(',')}
          >
            <Box
              inline
              width={1.8}
              height={2.4}
              backgroundColor="#d5ffff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>,</Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
          <Stack.Item
            style={{ cursor: 'pointer' }}
            onClick={() => keyHandler(' ')}
          >
            <Box
              width={8.7}
              height={2.4}
              backgroundColor="#d5ffff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              {' '}
            </Box>
          </Stack.Item>
          <Stack.Item
            style={{ cursor: 'pointer' }}
            onClick={() => keyHandler('.')}
          >
            <Box
              inline
              width={1.8}
              height={2.4}
              backgroundColor="#d5ffff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>.</Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
          <Stack.Item
            style={{ cursor: 'pointer' }}
            onClick={() => keyHandler('Enter')}
          >
            <Box
              inline
              width={3}
              height={2.4}
              backgroundColor="#beecff"
              textColor="#000"
              fontSize={1.2}
              style={{
                borderRadius: '4px',
              }}
            >
              <Stack fill align="center" justify="center">
                <Stack.Item>
                  <Icon name="arrow-turn-down" rotation={90} />
                </Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const ScreenMessages = (props : {
  enteredNumber: string;
  setEnteredNumber: React.Dispatch<React.SetStateAction<string>>;
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { act, data } = useBackend<Data>();
  const { my_number, published_numbers, our_contacts, our_blocked_contacts, current_conversation_messages, conversations, date } = data;
  const { enteredNumber, setEnteredNumber, setApp } = props;

  const [selectedContact, setSelectedContact] = useState<string | null>(null);
  const [messageText, setMessageText] = useState('');

  const handleKeyPress = (key: string) => {
    if (key === 'Backspace') {
      setMessageText(prev => prev.slice(0, -1));
    } else if (key === 'Enter') {
      handleSend();
    } else {
      setMessageText(prev => prev + key);
    }
  };

  const handleSend = () => {
    if (messageText && selectedContact) {
      act('send_message', {
        contact_number: selectedContact,
        message_text: messageText
      });
      setMessageText(''); //fuck you typescript
    }
  };

  const handleSelectContact = (contactNumber: string) => {
    setSelectedContact(contactNumber);
    act('view_conversation', { contact_number: contactNumber });
  };

  const getContactName = (contactNumber: string) => {
    const contact = our_contacts.find(c => c.number === contactNumber);
    if (contact) return contact.name;
    const published = published_numbers.find(p => p.number === contactNumber);
    if (published) return published.name;
    return contactNumber;
  };
  // largely copy pasted from screencontacts.tsx
  if (selectedContact) {
    return (
      <Stack vertical fill backgroundColor="#fff" textColor="#000">
        <Stack.Item backgroundColor="#0069ff" textColor="#fff" p={1}>
          <Stack align="center">
            <Icon
              name="arrow-left"
              onClick={() => setSelectedContact(null)}
              style={{ cursor: 'pointer' }}
            />
            <Stack.Item grow>{getContactName(selectedContact)}</Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item grow overflowY="auto">
          <Box fontSize={0.8} textAlign="center" textColor= '#969696'>{date}</Box>
          {current_conversation_messages?.map((msg, idx) => (
            // flex-end for INCOMING, flex-start for OUTGOING. left and right sides
            <Stack key={idx} mb={1} p={1} justify={msg.is_outgoing ? 'flex-end' : 'flex-start'}>
              <Box
                backgroundColor={msg.is_outgoing ? '#0069ff' : '#e0e0e0'} //TODO maybe change this to green if we do expensive vs cheap phones
                textColor={msg.is_outgoing ? '#fff' : '#000'}
                p={1}
                style={{ borderRadius: '8px', maxWidth: '70%', wordWrap: 'break-word' }}
              >
                {msg.message_text}
                <Box textAlign={msg.is_outgoing ? 'right' : 'left'} fontSize={0.7} mt={0.5} textColor={msg.is_outgoing ? '#ffffff' : '#303030'}>{msg.time}</Box>
              </Box>
            </Stack>
          ))}
        </Stack.Item>
        <Stack.Item p={1} backgroundColor="#f0f0f0" style={{ borderTop: '1px solid #ddd' }}>
          <style>{`
            @keyframes blink {
              0%, 50% { opacity: 1; }
              51%, 100% { opacity: 0; }
            }
            .cursor {
              display: inline-block;
              animation: blink 1s infinite;
              margin-left: 2px;
            }
          `}</style>
          <Box
            p={0.5}
            style={{
              backgroundColor: '#fff',
              borderRadius: '4px',
              border: '1px solid #ccc',
              minHeight: '2.5em'
            }}
          >
            {messageText}
            {messageText.length === 0 && selectedContact && <span className="cursor">|</span>}
          </Box>
        </Stack.Item>
        <Stack.Item mb={6}>
          <Keyboard onClick={handleKeyPress} />
        </Stack.Item>
      </Stack>
    );
  }

  const allContacts = Array.isArray(conversations)
    ? conversations
        .filter(c => c.number !== my_number)
        .sort((a, b) => {
          const aTime = typeof a.last_timestamp === 'number' ? a.last_timestamp : 0;
          const bTime = typeof b.last_timestamp === 'number' ? b.last_timestamp : 0;
          return bTime - aTime;
        }) // most recent first
        .map(c => ({ name: getContactName(c.number), number: c.number, lastMessage: c.last_message_text }))
    : [];

  const publishedButNoConversation = Array.isArray(published_numbers)
    ? published_numbers
        .filter(p => p.number !== my_number && !allContacts.some(c => c.number === p.number))
        .map(p => ({ name: p.name, number: p.number, lastMessage: undefined }))
    : [];

  const combinedContacts = [...allContacts, ...publishedButNoConversation];

  return (
    <Stack vertical fill backgroundColor="#fff" textColor="#000">
      <Stack.Item backgroundColor="#0069ff" textColor="#fff" p={1}>
        Messages
      </Stack.Item>
      <Stack.Item grow overflowY="auto">
        <Stack vertical>
          {combinedContacts?.map((contact) => (
            <ContactElement
              contact={contact}
              key={contact.name + contact.number}
              onClick={() => handleSelectContact(contact.number)}
              time={contact.lastMessage || contact.number}
            />
          ))}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
