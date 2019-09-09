import ApexCharts from 'apexcharts';

const changeGraph = () => {
  var days_in_the_past = 0;

  // SETTING LISTENERS AND CLASSES FOR FILTERS
  var sevenDayBtn = document.querySelector('#seven-day-view');
  var fifteenDayBtn = document.querySelector('#fifteen-day-view');
  var thirtyDayBtn = document.querySelector('#thirty-day-view');

  sevenDayBtn.addEventListener('click', (event) => {
    event.target.classList.add('opacity-50', 'cursor-not-allowed');
    fifteenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    thirtyDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    updateData(days_in_the_past);
  });

  fifteenDayBtn.addEventListener('click', (event) => {
    event.target.classList.add('opacity-50', 'cursor-not-allowed');
    sevenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    thirtyDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    updateData(days_in_the_past);
  });

  thirtyDayBtn.addEventListener('click', (event) => {
    event.target.classList.add('opacity-50', 'cursor-not-allowed');
    sevenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    fifteenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    updateData(days_in_the_past);
  });

  // SETTING LISTENERS AND CLASSES FOR BUTTONS
  let previousWeekBtn = document.querySelector('#previous-week');
  let nextWeekBtn = document.querySelector('#next-week');
  let previousDayBtn = document.querySelector('#previous-day');
  let nextDayBtn = document.querySelector('#next-day');

  previousWeekBtn.addEventListener('click', (event) => {
    if (previousWeekBtn.matches(".cursor-not-allowed") === false) {
      days_in_the_past += 7;
      updateData(days_in_the_past);
      nextWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      nextDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    }
  });

  nextWeekBtn.addEventListener('click', (event) => {
    if (nextWeekBtn.matches(".cursor-not-allowed") === false) {
      days_in_the_past -= 7;
      updateData(days_in_the_past);
      previousWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      previousDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    }
  });

  previousDayBtn.addEventListener('click', (event) => {
    if (previousDayBtn.matches(".cursor-not-allowed") === false) {
      days_in_the_past += 1;
      updateData(days_in_the_past);
      nextDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      nextWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    }
  });

  nextDayBtn.addEventListener('click', (event) => {
    if (nextDayBtn.matches(".cursor-not-allowed") === false) {
      days_in_the_past -= 1;
      updateData(days_in_the_past);
      previousDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      previousWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
    }
  });
}

var updateData = (days_in_the_past) => {
  fetch("/dashboard/1.json")
    .then(response => response.json())
    .then((data) => {
      setGraphRange(data.feelings, days_in_the_past);
    });
}


const setGraphRange = (feelings, days_in_the_past) => {
  var oldChart = document.querySelector("#chart");
  oldChart.innerHTML = '';
  var amountOfDays = 7;

  var sevenDayBtn = document.querySelector('#seven-day-view');
  var fifteenDayBtn = document.querySelector('#fifteen-day-view');
  var thirtyDayBtn = document.querySelector('#thirty-day-view');

  if (sevenDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 7;
  } else if (fifteenDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 15;
  } else if (thirtyDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 30;
  }

  let previousWeekBtn = document.querySelector('#previous-week');
  let nextWeekBtn = document.querySelector('#next-week');
  let previousDayBtn = document.querySelector('#previous-day');
  let nextDayBtn = document.querySelector('#next-day');

  if (days_in_the_past >= feelings.happiness.dates.length - amountOfDays ) {
    days_in_the_past = feelings.happiness.dates.length - amountOfDays;
    previousWeekBtn.classList.add('opacity-50', 'cursor-not-allowed');
    previousDayBtn.classList.add('opacity-50', 'cursor-not-allowed');
  } else if (days_in_the_past <= 0) {
    days_in_the_past = 0;
    nextWeekBtn.classList.add('opacity-50', 'cursor-not-allowed');
    nextDayBtn.classList.add('opacity-50', 'cursor-not-allowed');
  };

  var most_recent_day = feelings.happiness.dates.length - days_in_the_past;
  // console.log(`most_recent_day = ${most_recent_day}`);
  // console.log(`days_in_the_past = ${days_in_the_past}`);
  // console.log(`amountOfDays = ${amountOfDays}`);
  // console.log(`--------------------------------------`);
  updateGraph(feelings, most_recent_day, amountOfDays);
}

const updateGraph = (feelings, most_recent_day, amountOfDays) => {
  var options = {
    chart: {
      type: 'line',
      background: '#fff',
      toolbar: {
        show: true,
        tools: {
          download: true,
          selection: false,
          zoom: true,
          zoomin: true,
          zoomout: true,
          pan: true,
          reset: true | '<img src="/static/icons/reset.png" width="20">',
          customIcons: []
        },
        autoSelected: 'pan'
      },
      animations: {
          enabled: false,
      },
    },
    yaxis: {
        max: 6,
        min: 0,
        tickAmount: 6,
        decimalsInFloat: 5,
        labels: {
            show: false
        }
    },
    stroke: {
        curve: 'smooth'
        },
    series: [{
        name: 'Happiness',
        data: feelings.happiness.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Carefreeness',
        data: feelings.carefreeness.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Patience',
        data: feelings.patience.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Sleep',
        data: feelings.sleep.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
    }],
    xaxis: {
      categories: feelings.happiness.dates.slice(most_recent_day - amountOfDays, most_recent_day)
    }
  }
  var chart = new ApexCharts(document.querySelector("#chart"), options);
  chart.render();
}


export { changeGraph };
