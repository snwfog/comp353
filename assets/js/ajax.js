// Generated by CoffeeScript 1.3.3

$(function() {
  var d2, drawRating, noteAlert, recallTime;
  recallTime = 2000;
  setInterval(function() {
    return $.ajax({
      url: "index.php?ajax&notify_acquire=1",
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        return $.each(data, function(i, item) {
          return noteAlert("Your bid \"<b><a href=\"index.php?offer&id=" + item.id + "\">" + item.title + "</a></b>\"            just arrived at the garage. You may come and pick it up            during our regular business hour within the next <b>14</b> days.", "success");
        });
      }
    });
  }, recallTime);
  setInterval(function() {
    return $.ajax({
      url: "index.php?ajax&notify_expired_bids=1",
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        return $.each(data, function(i, item) {
          return noteAlert(("Your bids \"<b><a href=\"index.php?offer&id=" + item.id + "\">" + item.description + "</a></b>\"          was expired <b>") + moment(item.date, "YYYY-MM-DD").fromNow() + "</b>.", "warning");
        });
      }
    });
  }, recallTime);
  setInterval(function() {
    return $.ajax({
      url: "index.php?ajax&notify_receive=1",
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        return $.each(data, function(i, item) {
          return noteAlert("Hey, we just received your item \"<b><a href=\"index.php?offer&id=" + item.id + "\">" + item.title + "</a></b>\"            in our garage. Rest assured as we've already notified            the bidder to come and pick it up.", "success");
        });
      }
    });
  }, recallTime);
  setInterval(function() {
    return $.ajax({
      url: "index.php?ajax&notify_modify=1",
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        return $.each(data, function(i, item) {
          return noteAlert("The item \"<b><a href=\"index.php?offer&id=" + item.id + "\">" + item.title + "</a></b>\"                      has been modified by the owner.", "warning");
        });
      }
    });
  }, recallTime);
  setInterval(function() {
    return $.ajax({
      url: "index.php?ajax&warn=1",
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        return $.each(data, function(i, item) {
          return noteAlert("You received a warning for your post \"<b><a href=\"index.php?offer&id=" + item.id + "\">" + item.title + "</a></b>\"", "error");
        });
      }
    });
  }, recallTime);
  $.ajax({
    url: "index.php?ajax&is_admin=1",
    dataType: "json"
  }).done(function(data) {
    if (data != null) {
      if (data.is_admin != null) {
        return noteAlert("Hey <b>" + data.admin_username + "</b>,          you are now in <b>Rainbow Unicorn Mode</b>            AKA <b>Admin Mode</b>.", "success");
      }
    }
  });
  noteAlert = function(msg, type) {
    var n;
    return n = noty({
      layout: 'bottomRight',
      type: type,
      text: msg,
      animation: {
        open: {
          height: 'toggle'
        },
        close: {
          height: 'toggle'
        },
        easing: 'swing',
        speed: 200
      }
    });
  };
  $('#admin-member-search, #member-name').live('click keyup', function() {
    var evalStr;
    evalStr = "";
    if ($('input[name=order_by]:checked').val()) {
      evalStr += "&order_by=" + $('input[name=order_by]:checked').val();
      if ($('input[name=direction]:checked').val()) {
        evalStr += "&direction=" + $('input[name=direction]:checked').val();
      }
    }
    return $.ajax({
      url: "index.php?ajax&admin_member_search=" + $('#member-name').val() + evalStr,
      dataType: "json"
    }).done(function(data) {
      if (data != null) {
        $('#member-search-table').html("<tr><th>Position</th><th>User</th><th>Posts</th>          <th>Buys</th><th>Sells</th><th>Rating</th></tr>");
        return $.each(data, function(i, item) {
          return $('#member-search-table').append("<tr>" + ("<td>" + (i + 1) + "</td><td><div class='tiptip'>") + "<a href='index.php?member&id=" + item.id + "' class='button'>" + "<span class='icon icon191'>" + "</span><span class='label'>" + item.username + "</span></a></div></td>" + ("<td>" + item.posts + "</td>") + ("<td>" + item.buys + "</td>") + ("<td>" + item.sells + "</td>") + "<td>" + (item.rating === null ? "No Rating" : drawRating(item.rating) + "</td></tr>"));
        });
      }
    });
  });
  drawRating = function(rating) {
    var i, str, _i;
    str = "<span class='earned-rating'>";
    for (i = _i = 1; 1 <= rating ? _i <= rating : _i >= rating; i = 1 <= rating ? ++_i : --_i) {
      str += "$&nbsp;";
    }
    return str + "</span>";
  };
  d2 = [[0, 507812330], [1, 234232323], [2, 23393849], [9, 13]];
  $.plot($("#graph"), [
    {
      data: d2,
      bars: {
        show: true
      }
    }
  ], {
    xaxis: {
      show: false
    },
    yaxis: {
      font: {
        size: 17,
        weight: "bold",
        family: "Helvetica Neue"
      }
    }
  });
  return true;
});
