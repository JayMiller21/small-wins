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
    var container = document.getElementById(habit[0].replace(/\s+/g,"-") + '-timeline');
    var chart = new google.visualization.ColumnChart(container);

    var d = new Date();

    var data = new google.visualization.DataTable();
    data.addColumn({ type: 'date', id: 'Date' });
    data.addColumn({ type: 'number', id: 'Level' });
    data.addRows(habit[1].map(function(d){
      ary = [d,1];
      return ary;
    }));

    var options = {
    hAxis: {
      viewWindow:{
        max: new Date(d.getFullYear(),d.getMonth()+1,1),
        min: new Date(d.getFullYear(),d.getMonth(),0)
      },
      gridlines: {color: "whitesmoke"}
    },
    vAxis: {
      gridlines: {count: 0}
    },
    legend: {position: "none"},
    backgroundColor: {fill: "whitesmoke"},
    bar: {groupWidth: "21"}
    };
    
    chart.draw(data,options);

  };
};

$(document).ready(ready);
$(document).on('page:load', ready);
