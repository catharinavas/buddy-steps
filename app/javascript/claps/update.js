const increaseClaps = (dataset, claps) => {
  const clapCount = document.querySelector(`[data-publication='${dataset}']`);
  clapCount.innerText = claps;
}

const decreaseClaps = (dataset, claps) => {
  const clapCount = document.querySelector(`[data-publication='${dataset}']`);
    clapCount.innerText = claps;
}

export { increaseClaps, decreaseClaps };
