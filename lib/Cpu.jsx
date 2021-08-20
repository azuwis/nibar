import styles from "./styles.jsx";

const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  return (
    <div style={output.loadAverage > 4 ? { color: styles.colors.red } : null}>
      <span>􀍽 {output.loadAverage}</span>
    </div>
  );
};

export default render;
