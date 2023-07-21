/// @function GoogleSheet()
/// @description
///		Simple Google Sheet Downloader
///		By https://github.com/Dragon-Developer
function GoogleSheet() constructor {
	static manager = noone;
	/// @function	sheetManager()
	/// @description
	///		This will return the manager instance and create one if it doesn't exist
	static getManager = function() {
		if (manager == noone) {
			manager = instance_create_depth(0, 0, 0, google_sheet_manager);
		}
		else if (!instance_exists(manager)) {
			show_debug_message("Do not deactivate google_sheet_manager!");	
		}
		return manager;
	}
	/// @function	getDownloadURL()
	/// @description
	///		This function will return the Sheet Download URL or empty string if the given url is invalid.
	/// @param {String} url
	///		Example: https://docs.google.com/spreadsheets/d/KEY
	static getDownloadURL = function(_url) {
		var _split = string_split(_url, "/");
		// Invalid URL
		if (array_length(_split) <= 5) return "";
		var _key = _split[5];
		// GID is 0 by default
		var _gid = "0";
		_split = string_split(_url, "gid=");
		// If it contains gid= in URL, use it
		if (array_length(_split) >= 2)
			_gid = _split[1];
		// Return download url
		return string("https://docs.google.com/spreadsheets/d/{0}/export?format=csv&gid={1}", _key, _gid);
	}
	/// @function	download()
	/// @description
	///		Download given sheet as csv.
	/// @param {String} url
	///		Example: https://docs.google.com/spreadsheets/d/KEY
	/// @param {String} fname
	///		File name
	/// @param {Function} callback
	///		Function executed if the file has been downloaded
	/// @param {Function} error
	///		Function executed if the file hasn't been downloaded
	static downloadFile = function(_url, _fname, _callback, _error = function() {}) {
		var _download_url = getDownloadURL(_url);
		getManager().addRequest(
			http_get(_download_url),
			_callback, 
			_error,
			_fname);
	}
	/// @function	download()
	/// @description
	///		Download given sheet as csv.
	/// @param {String} url
	///		Example: https://docs.google.com/spreadsheets/d/KEY
	/// @param {Function} callback
	///		Function executed if the file has been downloaded
	/// @param {Function} error
	///		Function executed if the file hasn't been downloaded
	static downloadGrid = function(_url, _callback, _error = function() {}) {
		var _download_url = getDownloadURL(_url);
		getManager().addRequest(
			http_get(_download_url),
			_callback, 
			_error);
	}
	/// @function	loadFile()
	/// @param {String} fname
	///		Name of the file that contains the sheet in csv format
	/// @returns {Id.DsGrid}
	static loadGrid = function(_fname) {
		return load_csv(_fname);	
	}
}
global.googleSheet = new GoogleSheet();