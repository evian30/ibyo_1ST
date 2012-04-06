var upload_seq = 0;
var upload_current = 0;
var upload_count = 0;
// upload old
function fnMUploadOld(upload_key, upload_name){
	upload_seq++;
	fnMUploadCreatView(upload_seq, upload_name, upload_key);
}
// upload delete
function fnMUploadCancel(upload_id){
	var uploadDataObj = document.getElementById("upload_data" + upload_id);
	var uploadViewObj = document.getElementById("upload_view" + upload_id);
	if(uploadViewObj.data == "new"){
		uploadDataObj.removeNode(true);
		upload_count--;
	}else{
		var uploadDataObj = document.createElement("INPUT");
		uploadDataObj.type = "hidden";
		uploadDataObj.name = "upload_delete";
		uploadDataObj.value = uploadViewObj.data;
		uploadData.appendChild(uploadDataObj);
	}
	uploadViewObj.removeNode(true);
}
// view create
function fnMUploadCreatView(upload_id, upload_name, state){
	var uploadViewObj = document.createElement("DIV");
	uploadViewObj.id = "upload_view" + upload_id;
	uploadViewObj.data = state;
	uploadViewObj.innerHTML = upload_name + " <a href=\"javascript:fnMUploadCancel('" + upload_id + "');\">[delete]</a>";
	uploadView.appendChild(uploadViewObj);
}
function fntt(){
}
// upload
function fnMUpload(uploadDataObj){
	if(uploadDataObj.value != ""){
		fnMUploadCreatView(upload_current, uploadDataObj.value, "new");
		upload_count++;
	}

	document.getElementById("upload_data" + upload_seq).style.display = "none";
	upload_seq++;
	upload_current = upload_seq;
	var sName = "upload_data" + upload_seq;
    var uploadDataObj = document.createElement("<input type=file id='" + sName + "' name='upload' onChange='fnMUpload(this)' style='width:0;cursor:pointer'>");
	uploadData.insertAdjacentElement("afterBegin", uploadDataObj);
}
