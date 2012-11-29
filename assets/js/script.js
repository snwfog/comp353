// Generated by CoffeeScript 1.3.3
/*
Do NOT modify .js file, modify only the .coffee file 
This script is used for data validation, and ajax.
This script is NOT for UI, or animation, do that in global-script instead.
*/

$(document).ready(function() {
  var bidOfferValidator, creditCardValidator, displayError, loginValidator, noteAlert, noteConfirm, noteFormConfirm, postOfferValidator;
  $('.tiptip a.button, .tiptip button').tipTip();
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
      },
      timeout: 5000
    });
  };
  noteConfirm = function(msg, url) {
    var n;
    return n = noty({
      layout: 'center',
      type: 'alert',
      text: msg,
      modal: true,
      animation: {
        open: {
          height: 'toggle'
        },
        close: {
          height: 'toggle'
        },
        easing: 'swing',
        speed: 50
      },
      buttons: [
        {
          addClass: 'btn btn-primary',
          text: 'Continue',
          onClick: function($noty) {
            $noty.close();
            return window.location = url;
          }
        }, {
          addClass: 'btn btn-danger',
          text: 'Cancel',
          onClick: function($noty) {
            return $noty.close();
          }
        }
      ]
    });
  };
  noteFormConfirm = function(msg, event) {
    var n;
    return n = noty({
      layout: 'center',
      type: 'alert',
      text: msg,
      modal: true,
      animation: {
        open: {
          height: 'toggle'
        },
        close: {
          height: 'toggle'
        },
        easing: 'swing',
        speed: 50
      },
      buttons: [
        {
          addClass: 'btn btn-primary',
          text: 'Continue',
          onClick: function($noty) {
            return $noty.close();
          }
        }, {
          addClass: 'btn btn-danger',
          text: 'Cancel',
          onClick: function($noty) {
            return $noty.close();
          }
        }
      ]
    });
  };
  $(".delete, .confirm").live('click', function() {
    this.blur();
    return false;
  });
  $('.delete').click(function() {
    var loc;
    loc = $(this).attr("href");
    return noteConfirm("Are you sure you want to perform a delete?", loc);
  });
  $('.confirm').click(function() {
    var loc;
    loc = $(this).attr("href");
    return noteConfirm("Are you sure you want to accept this offer?", loc);
  });
  displayError = function(errors, event) {
    var error, errorString, _i, _len, _results;
    if (errors.length > 0) {
      errorString = "";
      _results = [];
      for (_i = 0, _len = errors.length; _i < _len; _i++) {
        error = errors[_i];
        _results.push(noteAlert(error.message, "warning"));
      }
      return _results;
    } else {
      return confirm("Ready to submit your form?");
    }
  };
  /*
      Login Form Validator
  */

  loginValidator = new FormValidator("login-form", [
    {
      name: 'username',
      display: 'Username',
      rules: 'required|max_length[30]'
    }, {
      name: 'password',
      display: 'Password',
      rules: 'required'
    }
  ], displayError);
  /*
      Post Offer Form Validator
  */

  postOfferValidator = new FormValidator("post-offer-form", [
    {
      name: "title",
      rules: "required|max_length[50]"
    }, {
      name: "category",
      rules: "required"
    }, {
      name: "price",
      rules: "required|numeric"
    }, {
      name: "description",
      rules: "required"
    }
  ], displayError);
  /*
      Bid On Offer Form Validator
  */

  bidOfferValidator = new FormValidator("bid-offer-form", [
    {
      name: "category",
      rules: "required"
    }, {
      name: "price",
      rules: "required|numeric"
    }, {
      name: "description",
      rules: "required|max_length[100]"
    }
  ], displayError);
  /*
      Credit Card Information
  */

  return creditCardValidator = new FormValidator("credit-card-form", [
    {
      name: "credit_card_type",
      display: "Credit Card Type",
      rules: "required"
    }, {
      name: "card_holder",
      display: "Holder's Name",
      rules: "required|alpha"
    }, {
      name: "credit_card_number",
      display: "Credit Card Number",
      rules: "required|numeric|exact_length[16]"
    }, {
      name: "expiration_month",
      display: "Expire Month",
      rules: "required|numeric|exact_length[2]"
    }, {
      name: "expiration_year",
      display: "Expire Year",
      rules: "required|numeric|exact_length[2]"
    }, {
      name: "verification_number",
      display: "Verification Number",
      rules: "required|numberic|less_than[4]"
    }
  ], displayError);
});
