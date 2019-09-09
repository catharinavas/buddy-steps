import ApexCharts from 'apexcharts';

var fetchGraphData = () => {
  fetch("/dashboard.json")
    .then(response => response.json())
    .then((data) => {
      generateGraph(data.feelings);
    });
}

var generateGraph = (feelings) => {
  const total_days = feelings.happiness.dates.length
  var options = {
    chart: {
      type: 'line',
      background: '#fff',
      height: '200rem',
    },
    legend: {
      position: 'top'
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
        data: feelings.happiness.intensities.slice(total_days - 7, total_days)
        }, {
        name: 'Carefreeness',
        data: feelings.carefreeness.intensities.slice(total_days - 7, total_days)
        }, {
        name: 'Patience',
        data: feelings.patience.intensities.slice(total_days - 7, total_days)
        }, {
        name: 'Sleep',
        data: feelings.sleep.intensities.slice(total_days - 7, total_days)
    }],
    xaxis: {
      categories: feelings.happiness.dates.slice(total_days - 7, total_days)
    }
  }

  var chart = new ApexCharts(document.querySelector("#chart"), options);
  chart.render();


}

export { fetchGraphData };
