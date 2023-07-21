requests = {};

addRequest = function(_req, _callback, _error, _path = "") {
	requests[$ _req] = {
		callback: _callback,
		error: _error,
		path: _path
	};
}