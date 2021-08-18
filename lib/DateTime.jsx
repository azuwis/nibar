const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  return (
    <div>
      {output.datetime}
    </div>
  );
};

export default render;
