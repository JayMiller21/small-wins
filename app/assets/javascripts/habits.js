// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var ready;
ready = function() {

  // google.load('visualization', '1.0', { packages:["timeline"] });
  google.setOnLoadCallback(habits.forEach(drawChart));

  function drawChart(habit,index,array) {
    var container = document.getElementById(habit[0] + '-timeline');
    var chart = new google.visualization.AreaChart(container);
    // var dataTable = new google.visualization.DataTable();
    var d = new Date();

    var data = google.visualization.arrayToDataTable([
          ['Date', 'HabCompleted'],
          [new Date(), 1],
          [new Date(2015,8,27), 1]
        ]);

    // dataTable.addColumn({ type: 'string', id: 'President' });
    // dataTable.addColumn({ type: 'date', id: 'Start' });
    // dataTable.addColumn({ type: 'date', id: 'End' });
    // dataTable.addRows(
    //   [habit]);

    chart.draw(data,{
      hAxis: { 
        viewWindowMode:'explicit',
        viewWindow:{
          max: new Date(d.getFullYear(),d.getMonth()+1,0),
          min: new Date(d.getFullYear(),d.getMonth(),1)
        }
      }
    });
  }

};

$(document).ready(ready);
$(document).on('page:load', ready);