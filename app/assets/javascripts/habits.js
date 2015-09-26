// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var ready;
ready = function() {

  google.setOnLoadCallback(function(){
    for (i=0; i<habits.length; i++) {
      if (habits[i] !== null) {
        drawChart(habits[i]);
      }
    }
  });

  function drawChart(habit) {
    var container = document.getElementById(habit[0] + '-timeline');
    var chart = new google.visualization.AreaChart(container);

    var d = new Date();

    var data = google.visualization.arrayToDataTable([
          ['Date', 'Completed?'],
          [habit[1], 1],
          [habit[2], 1]
        ]);

    chart.draw(data,{
      hAxis: { 
        viewWindow:{
          max: new Date(d.getFullYear(),d.getMonth()+1,0),
          min: new Date(d.getFullYear(),d.getMonth(),1)
        },
        gridlines: {color: "whitesmoke"}
      },
      vAxis: {
        gridlines: {count: 0}
      },
      legend: {position: "none"},
      backgroundColor: {fill: "whitesmoke"}
    });
  }

};

$(document).ready(ready);
$(document).on('page:load', ready);
