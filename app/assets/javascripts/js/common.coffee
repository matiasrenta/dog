# init datatables

square = () ->
  $('.table').DataTable
    language:
      'sProcessing': 'Procesando...'
      'sLengthMenu': 'Mostrar _MENU_ registros'
      'sZeroRecords': 'No se encontraron resultados'
      'sEmptyTable': 'Ningún dato disponible en esta tabla'
      'sInfo': 'Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros'
      'sInfoEmpty': 'Mostrando registros del 0 al 0 de un total de 0 registros'
      'sInfoFiltered': '(filtrado de un total de _MAX_ registros)'
      'sInfoPostFix': ''
      'sSearch': 'Buscar:'
      'sUrl': ''
      'sInfoThousands': ','
      'sLoadingRecords': 'Cargando...'
      'oPaginate':
        'sFirst': 'Primero'
        'sLast': 'Último'
        'sNext': 'Siguiente'
        'sPrevious': 'Anterior'
      'oAria':
        'sSortAscending': ': Activar para ordenar la columna de manera ascendente'
        'sSortDescending': ': Activar para ordenar la columna de manera descendente'
    autoWidth: false
    info: false
    searching: false
    ordering: false
    paging: false
    # language: url: 'assets/js/plugin/datatables/dataTables.spanish.json'
    responsive:
      details:
        renderer: (api, rowIdx) ->
          data = (api.cells rowIdx, ':hidden').eq(0).map( (cell) ->
            header = $((api.column cell.column).header())
            "<p>#{header.text()}: #{(api.cell cell).data()}</p>"
          ).toArray().join('');
          false
          return if data? then $('<table/>').append( data ) else false

setTimeout(square, 100)

$(document).on "page:change", ->
  $(".dropzone").dropzone()
