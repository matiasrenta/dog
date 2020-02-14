jQuery ->
  $('.notification_panel').scroll ->
    url = $('.notification_panel a[rel=next]').attr('href')
    if url && $('.notification_panel').scrollTop() > $('#infinity_scrollable').height() - $('.notification_panel').height() - 50
      # $('.notification_panel .pagination').text("Fetching more products...")
      $('.notification_panel .pagination').html('<h1 class="ajax-loading-animation"><i class="fa fa-cog fa-spin"></i> Loading...</h1>');
      $.getScript(url)
  $('.notification_panel').scroll()
