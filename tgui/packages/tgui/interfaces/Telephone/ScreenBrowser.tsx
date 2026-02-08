// THIS IS A DARKPACK UI FILE
import { useState, useEffect, useMemo, useRef, memo } from 'react';
import { Box, Icon, Stack } from 'tgui-core/components';
import { NavigableApps } from '.';
import { resolveAsset } from 'tgui/assets';

// web pages. just html in a `` block in a typescript file. sue me.
import { browser_home } from './pages/home';
import { browser_endron } from './pages/endron';
import { browserStyles } from './pages/browserStyles';

export const ScreenBrowser = memo((props: {
setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
const { setApp } = props;

const [currentSite, setCurrentSite] = useState<string>('Enter a URL');
const [urlInput, setUrlInput] = useState<string>('');
const endronContentRef = useRef<string | null>(null);
const contentBoxRef = useRef<HTMLDivElement>(null);

const websites = useMemo(() => ({
	'Home': browser_home,
	'Enter a URL': browser_home,
	'www.endron-international.com': () => {
		if (!endronContentRef.current) {
			endronContentRef.current = browser_endron();
		}
		return endronContentRef.current;
	},
}), []);

const handleNavigate = () => {
    if (urlInput.trim()) {
        setCurrentSite(urlInput.trim());
        setUrlInput(`https://${urlInput.trim()}`); // pretend to be a real browser!
    }
};

const handleKeyPress = (e: React.KeyboardEvent<HTMLInputElement>) => {
	if (e.key === 'Enter') {
	handleNavigate();
	}
};

const siteContent = useMemo(() => {
	const site = websites[currentSite];
	if (typeof site === 'function') {
		return site();
	}
	return site || `<div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;"><h1>Error 404</h1><p>Page "${currentSite}" not found</p></div>`;
}, [currentSite]);

useEffect(() => {
	if (contentBoxRef.current) {
		contentBoxRef.current.innerHTML = siteContent;
	}
}, [siteContent]);

return (
    <Stack vertical fill backgroundColor="#fff" textColor="#000">
    <style>{browserStyles}</style>
    <Stack.Item backgroundColor="rgb(0, 166, 172)" textColor="#fff" p={1}>
        <Stack align="center">
        <Icon
            name="arrow-left"
            onClick={() => currentSite == 'Enter a URL' ? setApp(null) : setCurrentSite('Enter a URL')}
            style={{ cursor: 'pointer' }}
        />
        <Stack.Item grow>EndBrowser v1.0.1</Stack.Item>
        </Stack>
    </Stack.Item>

    <Stack.Item p={1} backgroundColor="#f5f5f5" style={{ borderBottom: '1px solid #ddd' }}>
        <Stack>
        <Stack.Item grow>
            <input
            placeholder= 'Enter a URL'
            value={urlInput}
            onChange={(e) => setUrlInput(e.target.value)}
            onKeyDown={(e) => handleKeyPress(e as React.KeyboardEvent<HTMLInputElement>)}
            style={{
                width: '100%',
                padding: '0.5em',
                borderRadius: '4px',
                border: '1px solid #ccc',
                fontSize: '0.9em',
                boxSizing: 'border-box',
            }}
            />
        </Stack.Item>
        <Stack.Item>
            <Box
            onClick={handleNavigate}
            style={{
                padding: '0.5em 1em',
                backgroundColor: 'rgb(0, 166, 172)',
                color: '#fff',
                borderRadius: '4px',
                cursor: 'pointer',
                textAlign: 'center',
                userSelect: 'none',
            }}
            >
            Go
            </Box>
        </Stack.Item>
        </Stack>
    </Stack.Item>

    <Stack.Item grow style={{ overflow: 'auto' }}>
        <div
        ref={contentBoxRef}
        style={{
            height: '100%',
            overflowY: 'auto',
            backgroundColor: '#fff',
            paddingLeft: '1em',
        }}
        />
    </Stack.Item>

    <Stack.Item
        p={1}
        backgroundColor="#f5f5f5"
        style={{ borderTop: '1px solid #ddd', fontSize: '0.8em'}}
    >
    </Stack.Item>
    </Stack>
);
});
