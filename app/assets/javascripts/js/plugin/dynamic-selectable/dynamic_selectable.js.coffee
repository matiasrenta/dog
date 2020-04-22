$.fn.extend
  dynamicSelectable: ->
    $(@).each (i, el) ->
      new DynamicSelectable($(el))

class DynamicSelectable

  constructor: ($select) ->
    @init($select)

  init: ($select) ->
    @urlTemplate = $select.data('dynamicSelectableUrl')
    @$targetSelect = $($select.data('dynamicSelectableTarget'))
    $select.on 'change', =>
      @clearTarget()
      url = @constructUrl($select.val())
      if url
        $.getJSON url, (data) =>

          #este if lo puse yo @matiasrenta, para que si viene un solo valor lo ponga como selected
          if data.length == 1
            $.each data, (index, el) =>
              @$targetSelect.append "<option value='#{el.id}' selected>#{el.name}</option>"
          else
            $.each data, (index, el) =>
              @$targetSelect.append "<option value='#{el.id}'>#{el.name}</option>"
              # reinitialize target select

          @reinitializeTarget()
      else
        @reinitializeTarget()

  reinitializeTarget: ->
    @$targetSelect.trigger("change")

  clearTarget: ->
    @$targetSelect.html('<option></option>')

  constructUrl: (id) ->
    if id && id != ''
      @urlTemplate.replace(/:.+_id/, id)
