$(document).on('nested:fieldAdded', function(event){
    // this field was just inserted into your form
    var field = event.field;
    // it's a jQuery object already! Now you can find date input
    var fields_disabled = field.find('.enable_me');
    fields_disabled.prop("disabled", false);
})