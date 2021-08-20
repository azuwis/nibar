const format = (num) => {
  num /= 1024;
  if (num < 1024) return `${num.toFixed(1)}K`;
  num /= 1024;
  return `${num.toFixed(1)}M`;
};

const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  return (
    <div>
      <span>
        {format(output.ispeed)}↓ {format(output.ospeed)}↑
      </span>
    </div>
  );
};

export default render;
