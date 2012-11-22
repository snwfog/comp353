$ ->
################################################################################
# Fetch expired bids function handler
################################################################################
  $.ajax({
    url: "index.php?ajax&notify_expired_bids=1",
    dataType: "json"
  }).done (data) ->
    if data?
      $.each data, (i, item) ->
        noteAlert "Your bids \"#{item.description}\"
          was expired on #{item.date}.", "warning"

################################################################################
# Noty Confirmation Setup
# Since this function is in the local scope of the script.coffee
# I just copy & pasted here for simplicity
################################################################################

  noteAlert = (msg, type) ->
    n = noty({
      layout: 'bottomRight',
      type: type,
      text: msg,
      animation: {
        open: {height: 'toggle'},
        close: {height: 'toggle'},
        easing: 'swing',
        speed: 200
      },
    })