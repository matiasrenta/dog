$(document).ready(function() {

  // Login (remember-me)
	$("input[name='user[remember_me]']").val('0');
	$("input[name='remember']").change(function() {
		if ($("input[name='user[remember_me]']").val() == '1') {
			$("input[name='user[remember_me]']").val('0');
		} else {
			$("input[name='user[remember_me]']").val('1');
		}
	});

});

//Exportar a excel -cambia action-
function export_list() {
	var actionOrigin = $("form[name='filter_form']").attr('action');
	$("form[name='filter_form']").attr('action', actionOrigin + '.xlsx').submit();
	var actionNew = $("form[name='filter_form']").attr('action').slice(0,-5);
	$("form[name='filter_form']").attr('action', actionNew);
};
