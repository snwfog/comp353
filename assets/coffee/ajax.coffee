$ ->

################################################################################
# Fetch ready for pickup offer function handler
################################################################################
  recallTime = 2000

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
# Offer modified notifier
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
# Fetch warning alert
################################################################################
  setInterval ->
    $.ajax({
      url: "index.php?ajax&warn=1",
      dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "You received a warning for your post \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"", "error"
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

################################################################################
# Admin member search
################################################################################
  $('#admin-member-search, #member-name').live 'click keyup', ->
    evalStr = ""
    if $('input[name=order_by]:checked').val()
      evalStr += "&order_by=" + $('input[name=order_by]:checked').val()
      if $('input[name=direction]:checked').val()
        evalStr += "&direction=" + $('input[name=direction]:checked').val()

    $.ajax({
      url: "index.php?ajax&admin_member_search=" + $(this).val() + evalStr,
      dataType: "json"
    }).done (data) ->
      if data?
        $('#member-search-table').html "<tr><th>Position</th><th>User</th><th>Posts</th>
          <th>Buys</th><th>Sells</th><th>Rating</th></tr>"
        $.each data, (i, item) ->
          $('#member-search-table').append "<tr>" +
            "<td>#{i+1}</td><td><div class='tiptip'>" +
            "<a href='index.php?member&id=" + item.id + "' class='button'>" +
            "<span class='icon icon191'>" +
            "</span><span class='label'>" + item.username + "</span></a></div></td>" +
            "<td>#{item.posts}</td>" +
            "<td>#{item.buys}</td>" +
            "<td>#{item.sells}</td>" +
            "<td>" + if item.rating is null then "No Rating" else drawRating(item.rating) + "</td></tr>"

  drawRating = (rating) ->
    str = "<span class='earned-rating'>"
    for i in [1..rating]
      str += "$&nbsp;"
    return str + "</span>"
