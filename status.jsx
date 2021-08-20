import DateTime from "./lib/DateTime.jsx";
import Battery from "./lib/Battery.jsx";
import Cpu from "./lib/Cpu.jsx";
import Wifi from "./lib/Wifi.jsx";
import Network from "./lib/Network.jsx";
import Error from "./lib/Error.jsx";
import parse from "./lib/parse.jsx";
import styles from "./lib/styles.jsx";

const style = {
  display: "grid",
  padding: "0 12px",
  gridAutoFlow: "column",
  gridGap: "12px",
  position: "fixed",
  overflow: "hidden",
  right: "0px",
  top: "0px",
  color: styles.colors.dim,
  fontFamily: styles.fontFamily,
  fontSize: styles.fontSize,
  lineHeight: styles.lineHeight,
  fontWeight: styles.fontWeight
};

export const refreshFrequency = 10000;

export const command = "./nibar/scripts/status.sh";

export const render = ({ data }) => {
  if (typeof data === "undefined") {
    return (
      <div style={style}>
        <Error msg="Error: unknown script output" side="right" />
      </div>
    );
  }
  return (
    <div style={style}>
      <Network output={data.network} />
      <Cpu output={data.cpu} />
      <Wifi output={data.wifi} />
      <Battery output={data.battery} />
      <DateTime output={data.datetime} />
    </div>
  );
};

export const updateState = (event, previousState) => {
  let data = parse(event.output);
  if (data?.network) {
    data.network.ispeed = 0;
    data.network.ospeed = 0;
    if (previousState?.data) {
      const time = refreshFrequency / 1000;
      data.network.ispeed = (data.network.ibytes - previousState.data.network.ibytes) / time;
      data.network.ospeed = (data.network.obytes - previousState.data.network.obytes) / time;
    }
  }
  return { data };
};

export default null;
