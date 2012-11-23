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
        noteAlert "Your bids \"<b>#{item.description}</b>\"
          was expired <b>" + moment(item.date, "YYYY-MM-DD").fromNow() + "</b>.", "warning"

################################################################################
# Rainbow unicorn mode
################################################################################
  $.ajax({
    url: "index.php?ajax&is_admin=1",
    dataType: "json"
  }).done (data) ->
    if data?
      if data.is_admin?
        noteAlert "Hey <b>#{data.admin_username}</b>,
          you are now in <b>Rainbow Unicorn Mode</b>
          AKA <b>Admin Mode</b>.", "success"

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