var _id = async_load[? "id"];
var _status = async_load[? "status"];
var _http_status = async_load[? "http_status"];
// Invalid request
if (!variable_struct_exists(requests, _id)) return;
var _req = requests[$ _id];
var _result = async_load[? "result"];
var _path = _req.path;
var _valid = _http_status == 200 && !string_starts_with(_result, "<!doctype html>");
// Get status
// Success
if (_status == 0 && _valid) {
	var _load_grid = false;
	// If request has not path, use temporary file and remember to load grid
	if (_path == "") {
		_path = "temp.csv";
		_load_grid = true;
	}
	// Save result to file
	var _size = string_byte_length(_result);
	var _buffer = buffer_create(_size, buffer_fixed, 1);
	buffer_write(_buffer, buffer_text, _result);
	buffer_save(_buffer, _path);
	buffer_delete(_buffer);
	// If request has path, return path to load later
	if (_req.path != "") {
		_req.callback({
			status: _status,
			path: _req.path
		});
	} else {
		_req.callback({
			status: _status,
			grid: global.googleSheet.loadGrid(_path)
		});	
		file_delete(_path);
	}
	// No path, load directly to the memory
}
else if (_status != 1) {
	_req.error({
		status: _status
	});
	variable_struct_remove(requests, _id);
}