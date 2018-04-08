<html>
<link rel="stylesheet" href="style/PatientDashboardStyles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/Chart.bundle.min.js"></script>

<br/> 

	<div class="Test1" ">
	<form method="POST" action='SearchController' name="UploadFile" id="rowSubmitter">
		<input hidden type="text" name="jsonString" id="jsonString"/>
	</form>
	
	<div id="biometricsUploadBlock" style="margin-left:25%;">
		<form>
			<input id="csvUpload" type="file" />
		</form>
	</div>
	
	
	<div id="boimetricCsvTableContainer">
		<table id="biometricCsvTable" style="display:none" border="1"></table>
	</div>
	<div id="csvSubmitWrapper" style="display:none">
		<button id="biometricCsvSubmit" type="button" onclick="submitCsv()" >Submit CSV!</button>
	</div>
	
	<script src="./js/papaparse.min.js"></script>
	
	<script>
	var parsedJsonFromCsv;
	var biometricCsvUpload = document.getElementById('csvUpload');
	var deleteChildren = function (id) {
		var node = document.getElementById(id);
		if (!node) {
			return;
		}
		while (!!node.firstChild) {
			node.deleteChild(node.firstChild);
		}
	};
	
	var resetTableInDiv = function (tableId, divId) {
		var div = document.getElementById(divId);
		var table = document.getElementById(tableId);
		var emptyTableString = '<table id="' + tableId + '" style="display:none" border="1"></table>';
		
		div.removeChild(table);
		div.insertAdjacentHTML('afterbegin', emptyTableString);
	};
	
	
	
	biometricCsvUpload.addEventListener('change', function (event) {
		// check to ensure a single file has been selected
		if (!event.target.files) {
			deleteChildren('biometricCsvTable');
			return;
		}
		if (event.target.files.length !== 1) {
			alert('Please upload a single file at a time!');
			deleteChildren('biometricCsvTable');
			return;
		}
		
		var file = event.target.files[0];
		
		// check to see if the file is actually a csv
		if (file.name.indexOf('.csv') === -1) {
			alert('Please upload a csv file!');
			deleteChildren('biometricCsvTable');
			return;
		}
		document.getElementById('csvSubmitWrapper').style.display = 'block';
		// document.getElementById('biometricCsvSubmit').setAttribute('display', 'block');
		
		Papa.parse(file, {
			header: true,
			error: function (error, file, inputElement, reason) {
				alert('Please upload a valid csv file');
				return;
			},
			complete: function (results) {
				parsedJsonFromCsv = results;
				deleteChildren('biometricCsvTable');
				var table = document.getElementById('biometricCsvTable');
				table.style.display = 'none';
				
				if (!results.meta.fields) {
					alert('Please upload a csv with valid headers');
					return;
				}
				var tableHeadings = results.meta.fields;
				var tableHeaderString = '<tr>';
							
				// insert table heading
				tableHeadings.forEach(function (tH) {
					tableHeaderString += '<th>' + tH + '</th>';
				});
				tableHeaderString += '</tr>';
				table.insertAdjacentHTML('afterbegin', tableHeaderString);
				
				// insert table rows
				results.data.forEach(function (row) {
					var rowString = '<tr>'
					tableHeadings.forEach(function (heading) {
						rowString += '<td>' + row[heading] + '</td>';
					});
					rowString += '</tr>';
					table.insertAdjacentHTML('beforeend', rowString);
				});
				
				//unhide table
				table.style.display = 'table';
				
				console.log(results);
				// here, results.data is the csv itsef
				// TODO - need to add a constructor to make a table from the json.... too bad ng-repeat does not work here
			}
		});
	});
	
	function submitCsv () {
		var file = document.getElementById('csvUpload').files[0];
		Papa.parse(file, {
			header: true,
			complete: function (result) {
				var rows = result.data;
				document.getElementById('jsonString').setAttribute('value', JSON.stringify(rows));
				document.getElementById('rowSubmitter').submit();
			}
		});
	};
	
	</script>
</div>
</html>
