const increaseClaps = (dataset, claps) => {
  const clapCount = document.querySelector(`[data-publication='${dataset}']`);
  clapCount.innerText = claps;

  // const clapWrap = document.querySelector(`[data-clap-wrapID='${dataset}']`);
  // const claps = document.querySelector(`[data-clapID='${dataset}']`);
  // const clapIcon = document.querySelector(`[data-clap-iconID='${dataset}']`);

  // clapWrap.classList.toggle('bg-blue-300');
  // claps.classList.toggle('text-white');
  // clapIcon.classList.toggle('text-white');
}

const decreaseClaps = (dataset, claps) => {
  const clapCount = document.querySelector(`[data-publication='${dataset}']`);
    clapCount.innerText = claps;
}

export { increaseClaps, decreaseClaps };
