// Llamado a json con usuarios
var datos;
$.ajax({
  url: "../../users/mentionables.json",
  cache: false,
  async: false
}).done(function( data ) {
    datos = data;
  });
$('.mentions').mentionsInput({
	source: datos,
	showAtCaret: true
});
