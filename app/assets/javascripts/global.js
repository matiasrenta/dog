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


function select2_with_matcher_or(){
    // ver el codigo fuente del gem simple_form_auto_select2 para ver las clases otras clases que se le pueden agregar (con ajax, mukltiple etc) (url en gemfile). o bien inspeccionar el elemento antes que se le aplique .select2()
    $(document).find(".select2_with_matcher_or").select2({matcher: function(params, data) {return matchStart(params, data);}});
}


// Para agregar funcionalidad javascript a los fieds_added en nested forms. como ajax_dropdown, select2 o cualquier otro deberian ir todos aquí
$(document).on('nested:fieldAdded', function(event){
    //agrega ajax_drop_down que tiene la logica para obtener los ids
    nested_ajax_dropdown(event);
    // agrega select2
    nested_select2(event);
});

function nested_select2(event){
    // this field was just inserted into your form
    var field = event.field;

    // ver el codigo fuente del gem simple_form_auto_select2 para ver las clases otras clases que se le pueden agregar (con ajax, mukltiple etc) (url en gemfile). o bien inspeccionar el elemento antes que se le aplique .select2()
    field.find(".select2_with_matcher_or").select2({matcher: function(params, data) {return matchStart(params, data);}});

    // esto es para ponerle background color. el problema es que le pone a todos los selects porque está en global.js
    field.find(".select2_with_matcher_or_and_background").select2({matcher: function(params, data) {return matchStart(params, data);}, containerCssClass: 'custom-container', dropdownCssClass: 'custom-dropdown'});
}

// para que el select2 busque por OR operator. cada palabra que se escribe debe conisidir con cada inicio de palabra en el nombre del prducto
function matchStart(term, text) {
    var has = true;
    var words = term.toUpperCase().split(" ");
    for (var i =0; i < words.length; i++){
        var word = words[i];
        has = has && (text.toUpperCase().indexOf(word) >= 0);
    }
    return has;
}

function nested_ajax_dropdown(event){
    // this field was just inserted into your form
    var field = event.field;
    // it's a jQuery object already! Now you can find date input
    ajax_dropdown(field);

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
}




function ajax_dropdown(field_or_document){
    var dropdown_field = field_or_document.find('.ajax_dropdown');
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

        var obj = {};

        //parche para obtener el valor el product_id del order_detail form
        ep = this.getAttribute("data-findproductid");
        if(ep == 'true'){
            a = this.id.split('_'); // order_order_details_attributes_1589847633935_box_id
            pid = 'order_order_details_attributes_' + a[4] + '_product_id'; // este sería el html id del product
            obj["the_product_id"] = $("#" + pid).val();
        }

        var paramsToRetrieve = params_string.split(',');
        //$('#' + this.id).data("parameter") === this.id;

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

}
