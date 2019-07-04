//= require_tree ./modules/channels


function fillGame(width, height, cells) {
  for(var x = 0; x < width; x++) {
      for(var y = 0; y < height; y++) {
        var cell = $("<div class='cell_container'></div>");
        cell.attr('attr-pos', x + '_' + y)
        cell.css('left', x*10 + "px")
        cell.css('top', y*10 + "px")
        cell.appendTo('#game');
      }
  }
  $("#game").css('width', width*10)
  $("#game").css('height', height*10)
  cells = JSON.parse(cells.replace(/&quot;/g,'"'));
  for (var i = 0; i < cells.length; i++) {
    var cell_data = cells[i]
    fill_inital_cell(cell_data)
  }
}

function fill_inital_cell(cell_data) {
  var cell_pos = cell_data.pos_x + "_" + cell_data.pos_y
  var cell_container = $(".cell_container[attr-pos=" + cell_pos + "]");
  var cell_color = cell_data.player.color
  cell_container.css('background-color', cell_color)
  cell_container.css('display', 'block')
  cell_container.attr('title', cell_data.player.player_name)
}
