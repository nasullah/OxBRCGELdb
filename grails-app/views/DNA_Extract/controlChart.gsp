<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="kickstart" />
    <title>Control Chart</title>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/highcharts-more.js"></script>
</head>
<body>

<hr>

<div id="control" style="height:650px;width:1100px;margin:1em auto;"></div>

<script>
    Highcharts.dateFormats = {
        W: function (timestamp) {
            var date = new Date(timestamp),
                    day = date.getUTCDay() == 0 ? 7 : date.getUTCDay(),
                    dayNumber;
            date.setDate(date.getUTCDate() + 4 - day);
            dayNumber = Math.floor((date.getTime() - new Date(date.getUTCFullYear(), 0, 1, -6)) / 86400000);
            return 1 + Math.floor(dayNumber / 7);
        }
    };
    var chart;
    chart = new Highcharts.Chart({
        chart: {
            renderTo: 'control',
            defaultSeriesType: 'line',
            marginRight:60,
            marginLeft:60,
            backgroundColor: {
                linearGradient: [0, 0, 500, 500],
                stops: [
                    [0, 'rgb(255, 255, 255)'],
                    [1, 'rgb(240, 240, 255)']
                ]
            },
            borderWidth:1,
            borderColor:'#ccc',
            plotBackgroundColor:'#fff',
            plotBorderWidth:1,
            plotBorderColor:'#ccc'
        },
        credits:{
            enabled:false
        },
        title: {
            text: 'Qubit Concentration (2016-2017)'
        },
        tooltip: {
            borderWidth:1,
            formatter: function() {
                if(this.point.error){
                    var errorText = '<b>Flag: </b>' + this.point.error;
                }
                else{
                    var errorText = '';
                }
                return '<b>'+ this.series.name
                         +': '+ this.y +'(ng/ul)'+'<br/>'+
                        errorText;
            }
        },
        legend: {
            enabled:false
        },
        plotOptions:{
            series: {
                shadow: false,
                lineWidth:1,
                states: {
                    hover: {
                        enabled:true,
                        lineWidth:1
                    }
                },
                marker: {
                    enabled:true,
                    symbol:'diamond',
                    radius: 4,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
        xAxis: {
            title: {text: 'Weeks'},
            type: 'datetime',
            tickInterval: 7 * 24 * 36e5, // one week
            labels: {
                format: '{value:%W}',
                align: 'right',
                rotation: -30
            }
        },
        yAxis: {
            tickPositions:[10, 20, 30, 40, 50, 60 , 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200],
            plotLines:[{
                value:20,
                color:'rgba(162,29,33,.75)',
                width:1,
                zIndex:3
            },{
                value:85,
                color:'rgba(24,90,169,.75)',
                width:1,
                zIndex:3
            },{
                value:150,
                color:'rgba(162,29,33,.75)',
                width:1,
                zIndex:3
            }],
            title: {text: 'Concentration (ng/ul)'},
            lineWidth:0,
            gridLineWidth:1,
            gridLineColor:'rgba(24,90,169,.25)',
            startOnTick:false,
            endOnTick:false,
            minPadding:0,
            maxPadding:0,
            min:0,
            max:200
        },
        series: [{
            name:'Measure',
            data: ${dataList},
            pointInterval: 7 * 24 * 36e5,
            pointStart: Date.UTC(2016, 11, 1)

        }]
    });
</script>
</body>
</html>