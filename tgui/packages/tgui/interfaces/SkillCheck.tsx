// THIS IS A TFN UI FILE
// largely based on https://github.com/trekkspace/dbd-skillcheck-simulator/tree/master
import { useEffect, useRef } from 'react';
import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type SkillCheckData = {
  difficulty: number;
};

const SIZE = 145;
const CX = SIZE / 2;
const CY = SIZE / 2;
const RADIUS = 65;
const S_SIZE = 3.6;
const LINE_SIZE = 2;
const COLOR = '#ffffff';
const RPM = 0.75;
const DEG_PER_MS = (360 * RPM) / 1000;
const START_DELAY_MS = 500;
const EXPIRE_DELAY_MS = 2500;

function toRad(deg: number) {
  return ((deg - 90) * Math.PI) / 180;
}

function coolCircle(
  canvas: HTMLCanvasElement,
  goodStartDeg: number,
  goodEndDeg: number,
) {
  const canvasContext = canvas.getContext('2d')!;
  canvasContext.clearRect(0, 0, SIZE, SIZE);

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS,
    toRad(goodEndDeg),
    toRad(goodStartDeg),
    false,
  );
  canvasContext.lineWidth = LINE_SIZE;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS,
    toRad(goodStartDeg),
    toRad(goodEndDeg),
    false,
  );
  canvasContext.lineWidth = S_SIZE * 2 + 1;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS - S_SIZE,
    toRad(goodStartDeg),
    toRad(goodEndDeg),
    false,
  );
  canvasContext.lineWidth = LINE_SIZE;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS + S_SIZE,
    toRad(goodStartDeg),
    toRad(goodEndDeg),
    false,
  );
  canvasContext.lineWidth = LINE_SIZE;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS,
    toRad(goodStartDeg),
    toRad(goodStartDeg) + 0.02,
    false,
  );
  canvasContext.lineWidth = S_SIZE * 2 + 1;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();

  canvasContext.beginPath();
  canvasContext.arc(
    CX,
    CY,
    RADIUS,
    toRad(goodEndDeg) - 0.02,
    toRad(goodEndDeg),
    false,
  );
  canvasContext.lineWidth = S_SIZE * 2 + 1;
  canvasContext.strokeStyle = COLOR;
  canvasContext.stroke();
}

export const SkillCheck = () => {
  const { act, data } = useBackend<SkillCheckData>();
  const difficulty = data?.difficulty ?? 3;

  // difficulty: 1 = hardest (smallest zone), 5 = easiest (largest zone). add successes to the difficulty var on the back end to make the zone bigger, basically.
  const goodArcDeg = Math.max(20, 80 * ((difficulty - 1) / 4));
  const goodStart = useRef(Math.random() * 360);
  const goodEnd = goodStart.current + goodArcDeg;

  const canvasRef = useRef<HTMLCanvasElement>(null);
  const needleRef = useRef<HTMLDivElement>(null);
  const angleRef = useRef(0);
  const lastTimeRef = useRef<number | null>(null);
  const rafRef = useRef<number | null>(null);
  const doneRef = useRef(false);
  const activeRef = useRef(false);

  useEffect(() => {
    if (canvasRef.current) {
      coolCircle(canvasRef.current, goodStart.current, goodEnd);
    }
  }, []);

  useEffect(() => {
    const startTimeout = setTimeout(() => {
      activeRef.current = true;
      const tick = (now: number) => {
        if (doneRef.current) return;
        if (lastTimeRef.current === null) lastTimeRef.current = now;
        const delta = now - lastTimeRef.current;
        lastTimeRef.current = now;
        angleRef.current = (angleRef.current + DEG_PER_MS * delta) % 360;
        if (needleRef.current) {
          needleRef.current.style.transform = `rotate(${angleRef.current}deg)`;
        }
        rafRef.current = requestAnimationFrame(tick);
      };
      rafRef.current = requestAnimationFrame(tick);

      const expireTimeout = setTimeout(() => {
        if (doneRef.current) return;
        doneRef.current = true;
        if (rafRef.current !== null) cancelAnimationFrame(rafRef.current);
        act('skill_check_result', { result: 'fail' });
      }, EXPIRE_DELAY_MS);

      return () => clearTimeout(expireTimeout);
    }, START_DELAY_MS);

    return () => {
      clearTimeout(startTimeout);
      if (rafRef.current !== null) cancelAnimationFrame(rafRef.current);
    };
  }, []);

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.code !== 'Space' || doneRef.current || !activeRef.current) return;
      e.preventDefault();
      doneRef.current = true;
      if (rafRef.current !== null) cancelAnimationFrame(rafRef.current);

      const angle = angleRef.current;
      const start = goodStart.current % 360;
      const end = goodEnd % 360;
      let inZone: boolean;
      if (start < end) {
        inZone = angle >= start && angle <= end; // the missile knows where it is
      } else {
        inZone = angle >= start || angle <= end; // because it knows where it isnt
      }

      if (inZone) {
        const audio = new Audio(resolveAsset('skillcheck_good.ogg'));
        audio.volume = 0.33;
        audio.play();
      }
      act('skill_check_result', { result: inZone ? 'pass' : 'fail' });
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, []);

  return (
    <Window width={240} height={240} title="Skill Check" theme="skillcheck">
      <Window.Content>
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            height: '100%',
          }}
        >
          <div style={{ position: 'relative', width: SIZE, height: SIZE }}>
            <canvas
              ref={canvasRef}
              width={SIZE}
              height={SIZE}
              style={{ position: 'absolute', top: 0, left: 0 }}
            />
            <div
              ref={needleRef}
              style={{
                position: 'absolute',
                width: SIZE,
                height: SIZE,
                top: 0,
                left: 0,
              }}
            >
              <div
                style={{
                  position: 'absolute',
                  width: 14,
                  height: 100,
                  background:
                    'radial-gradient(red, rgba(22,4,4,0), transparent)',
                  bottom: '60%',
                  left: 'calc(50% - 7px)',
                }}
              />
            </div>
            <div
              style={{
                position: 'absolute',
                top: '50%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
                background: '#2c2c2c',
                color: '#ffffff',
                border: '1.5px solid #fff',
                borderRadius: 4,
                padding: '0.1rem 0.6rem',
                fontSize: 20,
                boxShadow: '0 2px 5px 0 rgba(104,104,104,0.4)',
                whiteSpace: 'nowrap',
                userSelect: 'none',
              }}
            >
              SPACE
            </div>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};
