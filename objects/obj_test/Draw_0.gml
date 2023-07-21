// Draw 
if (!ds_exists(file_grid, ds_type_grid)) {
	if (file_grid == -1)
		draw_text(x, y, "Downloading...");	
	else
		draw_text(x, y, "Download Error");	
	return;
}
// Draw table
var ww = ds_grid_width(file_grid);
var hh = ds_grid_height(file_grid);
var yy = 0;
var xx = 0;
var line_h = 32;
var char_h = string_height("M");
for (var i = 0; i < ww; i++) {
    for (var j = 0; j < hh; j++) {
		draw_rectangle(x + xx + 1, y + yy + 1, x + xx + column_space[i] - 1, y + yy + line_h - 1, true);
        draw_text(x + xx + 8, y + yy + (line_h - char_h) / 2, string(file_grid[# i, j]));
        yy += line_h;
    }
	xx += column_space[i];
    yy = 0;
}