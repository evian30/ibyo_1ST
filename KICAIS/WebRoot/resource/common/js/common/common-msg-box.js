function SGAlert(title, msg){
		Ext.MessageBox.alert(title, msg);
}

function SGConfirm(title, msg, execFunction){
	return Ext.MessageBox.confirm(title, msg, execFunction);
}

function require_once (filename) {
    var cur_file = {};
    cur_file[this.window.location.href] = 1;
 
    try {
        php_js_shared;
    } catch (e) {
        php_js_shared = {};
    }
    if (!php_js_shared.includes) {
        php_js_shared.includes = cur_file;
    }
    if (!php_js_shared.includes[filename]) {
        if (this.require(filename)) {
            return true;
        }
    } else {
        return true;
    }
    return false;
}
