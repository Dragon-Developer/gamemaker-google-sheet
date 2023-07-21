draw_set_font(fnt_default);
file_grid = -1;
column_space = [];
table_width = 0;
table_height = 0;
example_url = "https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit#gid=0";
sheet_url = example_url;
// Option 1 (save to file and load later as ds_grid)
downloadSheetFile = function() {
	global.googleSheet.downloadFile(
		sheet_url,
		"test.csv",
		function(result) {
			var grid = global.googleSheet.loadGrid(result.path);
			adjustTable(grid);
		},
		function(err) {
			file_grid = -2;
		}
	);	
}

// Option 2 (no file, returns ds_grid)
downloadSheetGrid = function() {
	global.googleSheet.downloadGrid(
		sheet_url,
		function(result) {
			adjustTable(result.grid);
		},
		function(err) {	
			file_grid = -2;
		}
	);
}

// This will download the google sheet and put in the table
downloadSheet = function() {
	// Delete previous grid
	if (ds_exists(file_grid, ds_type_grid)) {
		ds_grid_destroy(file_grid);
	}
	file_grid = -1;
	// Download new sheet
	sheet_url = get_string("Link", example_url);
	//downloadSheetFile(); // Option 1
	downloadSheetGrid(); // Option 2
}

// Adjust table to draw the given grid with correct spacing
adjustTable = function(grid) {
	if (!ds_exists(grid, ds_type_grid)) {
		file_grid = -2;
		return;
	}
	file_grid = grid;
	var ww = ds_grid_width(file_grid);
	var hh = ds_grid_height(file_grid);
	// Update table dimension for drawing
	table_width = 0;
	table_height = hh * 32;
	// Get adjusted column space
	for (var i = 0; i < ww; i++) {
		column_space[i] = 0;
		for (var j = 0; j < hh; j++) {
			column_space[i] = max(column_space[i], string_width(string(file_grid[# i, j])) + 32);
		}
		table_width += column_space[i];
	}	
}

downloadSheet();