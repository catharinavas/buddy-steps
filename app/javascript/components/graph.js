import ApexCharts from 'apexcharts';


const graph = document.getElementById('graph');

var fetchGraphData = () => {
if (graph) {
  fetch("/dashboard.json")
    .then(response => response.json())
    .then((data) => {
      generateGraph(data.feelings);
    });
  }
}

var generateGraph = (feelings) => {
  const total_days = feelings.happiness.dates.length
  var options = {
    chart: {
      type: 'line',
      background: '#fff',
      height: '200rem',
      animations: {
          enabled: false,
      },
      toolbar: {
          show: false
      },
    },
    colors: ['#38A89D', '#794ACF', '#F6993F', '#FFED4A'],
    legend: {
      position: 'bottom'
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
      categories: feelings.happiness.dates.slice(total_days - 7, total_days),
    }
  }

  var chart = new ApexCharts(document.querySelector("#chart"), options);
  chart.render();


}
export { fetchGraphData };
