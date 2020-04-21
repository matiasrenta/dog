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


// Para agregar el ajax_dropdown en un nested form
$(document).on('nested:fieldAdded', function(event){
    // this field was just inserted into your form
    var field = event.field;
    // it's a jQuery object already! Now you can find date input
    var dropdown_field = field.find('.ajax_dropdown');
    // and activate datepicker on it
    dropdown_field.change(function() {
        $('input[type=submit]').attr('disabled', true);
        var params_string = $('#' + this.id).data('parameter');
        if (params_string == undefined){
            params_string = this.id // si no existe data-parameter porque no lo setee en el html, pues por defecto usa el id de this
        }

        // el siguiente if es porque no puedo poner el nombre del parametro en parameter porque justamete
        // no sé como se llama debido a que es dinamico del nested form. por eso agregue este otro llamado extraparams
        if ($('#' + this.id).data('extraparams') != undefined) {
            params_string = params_string + ',' + $('#' + this.id).data("extraparams");
        }

        var paramsToRetrieve = params_string.split(',');
        //$('#' + this.id).data("parameter") === this.id;

        var obj = {};
        obj["the_id"] = $("#" + paramsToRetrieve[0]).val(); // solo por conveniencia algunas veces puede ser mejor desde rails obtener un id desde este param llamado "the_id", solo funciona para uno solo no para varios ids
        obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos

        for (var i = 1; i < paramsToRetrieve.length; i++){
            var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
            obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
        }

        $.ajax({url: this.getAttribute("data-url"),
            data: obj,
            dataType: 'script'})
    });

    // lo mismo que la de arriba con .ajax_dropdown, pero esta es para checkbox, solo cambia cuando asigna "obj["is_checked"] = xxxxxxx". Debería solo mejorar la funcion anterior preguntando que si el elemento es un checkbox entonces setear este parametro
    var checkbox_field = field.find('.ajax_checkbox');
    checkbox_field.change(function() {
        var params_string = $('#' + this.id).data('parameter');
        if (params_string == undefined){
            params_string = this.id
        }

        var paramsToRetrieve = params_string.split(',');
        var obj = {};
        for (var i = 0; i < paramsToRetrieve.length; i++){
            var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
            obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
            obj["is_checked"] = $("#" + this.id).attr('checked') ? "1" : "0"
            obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
        }

        $.ajax({url: this.getAttribute("data-url"),
            data: obj,
            dataType: 'script'})
    });
});