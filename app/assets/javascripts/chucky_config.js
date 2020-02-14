//alert("chucky_config");
// ******** Date-time picker ********* -->
$(function() {
	$.datetimepicker.setLocale('es');

	$('.datetimepicker').datetimepicker({
		lazyint : true,
		format : 'd/m/Y H:i'

	});

	$('.date-picker').datetimepicker({
		lazyint : true,
		timepicker : false,
		//mask:true,
		format : 'd/m/Y',
		closeOnDateSelect : true,
		scrollInput : false
	});

	//Mask del datetimepicker
	$('.date-picker').mask('00/00/0000');
	$('.datetimepicker').mask('00/00/0000 00:00');
});

//Mostrar / ocutar detalles en timeline
$(function() {

	$(".actions-hover .show-details").click(function(event) {
		event.preventDefault();
		var elem = $(this).closest("li").find(".detalles");
		$(elem).toggle("slow");
		$( ".actions-hover .show-details" ).tooltip( "hide", { effect: "explode", duration: 1000 } );
		var title = $(this).attr('data-original-title');
		if (title == 'Detalle de cambios') {
			$(this).attr('data-original-title','Ocultar detalles');
		} else {
			$(this).attr('data-original-title','Detalle de cambios');
		}

	});
});

// TOUR
$(function() {
	// Check width size - Hide for small screens
	function checkWidth() {
		var windowsize = $(window).width();
		if (windowsize < 768) {
			$(".div-tour").hide();

		} else {
			$(".div-tour").show();
		}
	}

	// Execute on load
	checkWidth();
	// Bind event listener
	$(window).resize(checkWidth);

	if ($('[data-step]').length < 4) {
		var ultima = "Sig. Página";
		var multi = true;
	} else {
		var ultima = "Terminar";
		var multi = false;
	}

	if (RegExp('tour2', 'gi').test(window.location.search)) {

		var currentStep = $('[data-step]').length;

		introJs().setOptions({
			'exitOnOverlayClick' : 'true',
			'skipLabel' : 'Cancelar',
			'doneLabel' : ultima,
			'tooltipPosition' : 'auto',
			'positionPrecedence' : ['right', 'left', 'bottom', 'top'],
			'nextLabel' : 'Siguiente',
			'prevLabel' : 'Anterior'
		}).goToStep(currentStep).start().oncomplete(function() {
			checkTour();
		});
	}

	$("#start-tour").click(function(event) {
		event.preventDefault();
		introJs().setOptions({
			'exitOnOverlayClick' : 'true',
			'skipLabel' : 'Cancelar',
			'doneLabel' : ultima,
			'tooltipPosition' : 'auto',
			'positionPrecedence' : ['right', 'left', 'bottom', 'top'],
			'nextLabel' : 'Siguiente',
			'prevLabel' : 'Anterior'
		}).start().oncomplete(function() {
			checkTour();
		});
	});

	function checkTour() {
		if (multi == true) {
			window.location.href = '/welcome/prueba.html?tour2=true';
		} else {
			window.location.search = "";
		}
	}

});

// Tooltips
$(document).ready(function() {
	$('[data-toggle="tooltip"]').tooltip();
	$('a.tooltipwithnofollow[rel="tooltip nofollow"]').tooltip();
});
// ******** Menu Minified ?? ********* -->
$(function() {
	$(".minifyme").click(function() {
		if (Cookies.get('nav') != "min") {
			Cookies.set('nav', 'min', {
				path : '/'
			});
		} else if (Cookies.get('nav') == "min") {
			Cookies.set('nav', 'max', {
				path : '/'
			});
		}
	});
});
$(document).ready(function() {

	//Bootstrap Wizard Validations
	var $validator = $("#wizard-1").validate({

		rules : {
			email : {
				required : true,
				email : "Your email address must be in the format of name@domain.com"
			},
			fname : {
				required : true
			},
			lname : {
				required : true
			},
			country : {
				required : true
			},
			city : {
				required : true
			},
			postal : {
				required : true,
				minlength : 4
			},
			wphone : {
				required : true,
				minlength : 10
			},
			hphone : {
				required : true,
				minlength : 10
			}
		},

		messages : {
			fname : "Please specify your First name",
			lname : "Please specify your Last name",
			email : {
				required : "We need your email address to contact you",
				email : "Your email address must be in the format of name@domain.com"
			}
		},

		highlight : function(element) {
			$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		},
		unhighlight : function(element) {
			$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
		},
		errorElement : 'span',
		errorClass : 'help-block',
		errorPlacement : function(error, element) {
			if (element.parent('.input-group').length) {
				error.insertAfter(element.parent());
			} else {
				error.insertAfter(element);
			}
		}
	});
});

$(document).ready(function() {

	$('#bootstrap-wizard-1').bootstrapWizard({
		'tabClass' : 'form-wizard',
		'onNext' : function(tab, navigation, index) {
			var $valid = $("#wizard-1").valid();
			if (!$valid) {
				$validator.focusInvalid();
				return false;
			} else {
				$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).addClass('complete');
				$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).find('.step').html('<i class="fa fa-check"></i>');
			}
		}
	});

	// fuelux wizard
	var wizard = $('.wizard').wizard();

	wizard.on('finished', function(e, data) {
		//$("#fuelux-wizard").submit();
		//console.log("submitted!");
		$.smallBox({
			title : "Congratulations! Your form was submitted",
			content : "<i class='fa fa-clock-o'></i> <i>1 seconds ago...</i>",
			color : "#5F895F",
			iconSmall : "fa fa-check bounce animated",
			timeout : 4000
		});

	});
});
// Filtros
$(function() {
	var bgs = $('.filter-zone');
	$('.filter-button').click(function () {
        var target = $($(this).data('target')).stop(true).slideToggle();
        bgs.not(target).filter(':visible').stop(true, true).slideUp();
    })
});

//Append button a input y select
var rel, placement, title, content, icon, idModal;

//Append help button a la derecha con popover
var rightPop = $('.field_with_popover_rt');
$(rightPop).each(function(){
	rel = $(this).data('pop');
	placement = $(this).data('placement');
	title = $(this).data('title');
	content = $(this).data('content');
	icon = $(this).data('icon');
	$(this).parent().addClass('input-group add-on').append('<div class="input-group-btn"><button type="button" class="btn btn-default" data-rel="'+rel+'" data-placement="'+placement+'" data-original-title="'+title+'" data-content="'+content+'"><i class="'+icon+'"></i></button></div>');
});

//Append help button a la izquierda con popover
var leftPop = $('.field_with_popover_lf');
$(leftPop).each(function(){
	rel = $(this).data('pop');
	placement = $(this).data('placement');
	title = $(this).data('title');
	content = $(this).data('content');
	icon = $(this).data('icon');
	$(this).parent().addClass('input-group add-on')
	$(this).before('<div class="input-group-btn"><button type="button" class="btn btn-default" data-rel="'+rel+'" data-placement="'+placement+'" data-original-title="'+title+'" data-content="'+content+'"><i class="'+icon+'"></i></button></div>');
});

//Append add button a la izquierda con tooltip y modal
var leftTool = $('.field_with_tooltip_lf');
$(leftTool).each(function(){
	toggle = $(this).data('toggle');
	title = $(this).data('title');
	icon = $(this).data('icon');
	idModal = $(this).data("id-modal");
	$(this).parent().addClass('input-group add-on');
	$(this).before('<div class="input-group-btn"><button type="button" class="btn btn-default" data-toggle="modal" data-tooltip="true" data-original-title="'+title+'" data-content="'+content+'" data-target="#'+idModal+'" data-backdrop="static"><i class="'+icon+'"></i></button></div>');
});

$("#" + idModal).on('shown.bs.modal', function () {
    $(this).find('input:text:visible:first').focus();
})

// activate popovers with hover states
$("[rel=popover-hover], [data-rel=popover-hover]").popover({
	trigger : "hover"
});
// Inicializa tooltip
$('[data-tooltip="true"]').tooltip();
