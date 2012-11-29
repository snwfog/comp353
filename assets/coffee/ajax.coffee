$ ->

################################################################################
# Fetch ready for pickup offer function handler
################################################################################
  recallTime = 5000

  setInterval ->
    $.ajax({
      url: "index.php?ajax&notify_acquire=1",
      dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "Your bid \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"
            just arrived at the garage. You may come and pick it up
            during our regular business hour within the next <b>14</b> days.", "success"
  , recallTime
################################################################################
# Fetch expired bids function handler
################################################################################
  setInterval ->
    $.ajax({
      url: "index.php?ajax&notify_expired_bids=1",
      dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "Your bids \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.description}</a></b>\"
          was expired <b>" + moment(item.date, "YYYY-MM-DD").fromNow() + "</b>.", "warning"
  , recallTime
################################################################################
# Fetch received offer function handler
################################################################################
  setInterval ->
    $.ajax({
      url: "index.php?ajax&notify_receive=1",
      dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "Hey, we just received your item \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"
            in our garage. Rest assured as we've already notified
            the bidder to come and pick it up.", "success"
  , recallTime
################################################################################
# Fetch expired bids function handler
################################################################################
  setInterval ->
    $.ajax({
      url: "index.php?ajax&notify_modify=1",
      dataType: "json"
      }).done (data) ->
        if data?
          $.each data, (i, item) ->
            noteAlert "The item \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"
                        has been modified by the owner.", "warning"
  , recallTime
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