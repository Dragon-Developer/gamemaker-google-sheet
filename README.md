# GameMaker Google Sheet v1.0
This is a Google Sheet Importer for GameMaker LTS.  
It downloads a sheet as csv file and converts it to ds_grid.  
Maybe it will convert to array in future versions.  
```gml
// Example url
var url = "https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit#gid=0";
```
## Usage:  
```gml
// Example 1: download sheet as file
var fname = "sheet.csv";
global.googleSheet.downloadFile(
    url,
    fname,
    function(result) {
        my_grid = load_csv(result.path);
    },
    function(err) {
        // Show error message
    }
);	
```
```gml
// Example 2: download sheet as ds_grid
global.googleSheet.downloadGrid(
    url,
    function(result) {
        my_grid = result.grid;
    },
    function(err) {	
        // Show error message
    }
);
```

Credits: Dragon-Developer  