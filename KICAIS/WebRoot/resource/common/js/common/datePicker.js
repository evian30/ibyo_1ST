
function SGDatePicker(dateField){
	var date = new Ext.form.DateField({
		format:'Y-m-d'
	});
	date.applyToMarkup(dateField);
}

function showCal(id,dateField) {
	var dp = new Ext.DatePicker({ renderTo:id, format:"Y-m-d", idField:dateField });
	var el = document.getElementById(dateField);
	if(el.value != ""){
		selectedDate = new Date(el.value);
		dp.setValue(selectedDate);
	}
	dp.addListener("select", onSelect);
}

function onSelect(datePicker,date){
    var dt = new Date(date);
    document.getElementById(datePicker.idField).value = dt.format("Y-m-d");
    datePicker.destroy();
}