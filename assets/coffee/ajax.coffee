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
# Fetch new bid function handler
################################################################################
  setInterval ->
    $.ajax({
      url: "index.php?ajax&notify_bid=1",
      dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "You received a new bid for your offer
            \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"
            approximately <b>" + moment(item.date, "YYYY-MM-DD hh:mm:ss").add('hours', 1).fromNow() + "</b>.", "success"
  , recallTime
################################################################################
# Fetch winning bids for current member
################################################################################
  setInterval ->
    $.ajax({
    url: "index.php?ajax&notify_winning_bid=1",
    dataType: "json"
    }).done (data) ->
      if data?
        $.each data, (i, item) ->
          noteAlert "You just won an offer
                      \"<b><a href=\"index.php?offer&id=#{item.id}\">#{item.title}</a></b>\"
                      approximately <b>" + moment(item.date, "YYYY-MM-DD hh:mm:ss").add('hours', 1).fromNow() + "</b>.
                      You will be billed accordingly to your bidding offer. Please see your
                      credit card transaction history for detail information.", "success"
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
          was expired <b>" + moment(item.date, "YYYY-MM-DD hh:mm:ss").add('hours', 1).fromNow() + "</b>.", "warning"
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
      url: "index.php?ajax&admin_member_search=" + $('#member-name').val() + evalStr,
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
################################################################################
# Admin category plot
################################################################################
  $('#admin-category').live 'click keyup', ->
    evalStr = ""
    if $('input[name=order_by]:checked').val()
      evalStr += "&order_by=" + $('input[name=order_by]:checked').val()
      if $('input[name=direction]:checked').val()
        evalStr += "&direction=" + $('input[name=direction]:checked').val()

    $.ajax({
      url: "index.php?ajax&admin_category=1" + evalStr,
      dataType: "json"
    }).done (data) ->
      if data?
        $('#volume-graph, #counts-graph').html ""

        category = []
        volume = []
        counts = []

        $.each data, (i, item) ->
          category.push item.name
          volume.push parseInt item.volume
          counts.push parseInt item.counts

        new Ico.LineGraph($('#volume-graph')[0], {
          one: volume
        }, {
          markers: 'circle',
          colours: { one: 'pink' },
          labels: category,
          meanline: false,
          grid: true,
          grid_colour: "#EEEEEE",
          stroke_width: "2px"
        })

        new Ico.LineGraph($('#counts-graph')[0], {
          one: counts
        }, {
          markers: 'circle',
          colours: { one: 'orange' },
          labels: category,
          meanline: false,
          grid: true,
          grid_colour: "#EEEEEE",
          stroke_width: "2px"
        })
################################################################################
# Admin transaction plot
################################################################################
  $('#by_month, #by_week').live 'click', ->
    event.preventDefault()
    if ($(this).attr "id") is "by_month"
      by_what = "By Month"
      url = "&by_month=1"
    else if ($(this).attr "id") is "by_week"
      by_what = "By Week"
      url = "&by_week=1"
    $.ajax({
      url: "index.php?ajax&admin_transaction=1" + url,
      dataType: "json"
    }).done (data) ->
      if data?
        $('#by_what').html by_what
        $('#transaction-graph').html ""

        x_axis = []
        y_axis = []

        $.each data, (i, item) ->
          x_axis.push item.date
          y_axis.push parseInt item.counts

        new Ico.LineGraph($('#transaction-graph')[0], {
          one: y_axis
        }, {
          markers: 'circle',
          colours: { one: 'pink' },
          labels: x_axis,
          meanline: false,
          grid: true,
          grid_colour: "#EEEEEE",
          stroke_width: "2px"
        })

################################################################################
# Admin transaction plot
################################################################################
  $('#by_city, #by_country').live 'click', ->
    event.preventDefault()
    if ($(this).attr "id") is "by_city"
      by_what = "By City"
      url = "&by_city=1"
    else if ($(this).attr "id") is "by_country"
      by_what = "By Country"
      url = "&by_country=1"
    $.ajax({
      url: "index.php?ajax&admin_regions_and_territories=1" + url,
      dataType: "json"
    }).done (data) ->
      if data?
        $('#by_what').html by_what
        $('#transaction-graph').html ""

        x_axis = []
        y_axis = []

        $.each data, (i, item) ->
          x_axis.push item.location
          y_axis.push parseInt item.counts

        new Ico.LineGraph($('#transaction-graph')[0], {
        one: y_axis
        }, {
        markers: 'circle',
        colours: { one: 'pink' },
        labels: x_axis,
        meanline: false,
        grid: true,
        grid_colour: "#EEEEEE",
        stroke_width: "2px"
        })
################################################################################
# Admin garage earning plot
################################################################################
  $('#by_storage, #by_service').live 'click', ->
    event.preventDefault()
    if ($(this).attr "id") is "by_storage"
      by_what = "By Storage"
      url = "&by_storage=1"
    else if ($(this).attr "id") is "by_service"
      by_what = "By Service"
      url = "&by_service=1"
    $.ajax({
    url: "index.php?ajax&admin_buys_and_sells=1" + url,
    dataType: "json"
    }).done (data) ->
      if data?
        $('#by_what').html by_what
        $('#transaction-graph').html ""

        x_axis = []
        y_axis = []

        $.each data, (i, item) ->
          x_axis.push item.month
          y_axis.push parseInt item.amount

        new Ico.BarGraph($('#transaction-graph')[0], {
          one: y_axis
        }, {
          colours: { one: 'green' },
          labels: x_axis,
          meanline: false,
          grid: true,
        grid_colour: "#EEEEEE",
        })

  true