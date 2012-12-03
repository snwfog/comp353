// Generated by CoffeeScript 1.3.3
/*
Do NOT modify .js file, modify only the .coffee file 
This script is used for data validation, and ajax.
This script is NOT for UI, or animation, do that in global-script instead.
*/

$(document).ready(function() {
  var bidOfferValidator, creditCardValidator, displayError, loginValidator, noteAlert, noteConfirm, noteFormConfirm, postOfferValidator, registrationValidator;
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
  $(".delete, .confirm, .modify, .warn").live('click', function() {
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
  $('.warn').click(function() {
    var loc;
    loc = $(this).attr("href");
    return noteConfirm("Are you sure to send this warning to owner?", loc);
  });
  $('.modify').click(function() {
    var loc;
    loc = $(this).attr("href");
    return noteConfirm("Are you sure to modify this post?", loc);
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
      Post Offer Form Validator
  */

  postOfferValidator = new FormValidator("comment-form", [
    {
      name: "rating",
      display: "Rating",
      rules: "required"
    }, {
      name: "comment",
      display: "Comment",
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
      rules: "required|max_length[255]"
    }
  ], displayError);
  /*
      Credit Card Information
  */

  creditCardValidator = new FormValidator("credit-card-form", [
    {
      name: "credit_card_type",
      display: "Credit Card Type",
      rules: "required"
    }, {
      name: "card_holder",
      display: "Holder's Name",
      rules: "required"
    }, {
      name: "credit_card_number",
      display: "Credit Card Number",
      rules: "required|numeric|exact_length[16]"
    }, {
      name: "expiration_month",
      display: "Expire Month",
      rules: "required|numeric|exact_length[2]|less_than[13]|more_than[0]"
    }, {
      name: "expiration_year",
      display: "Expire Year",
      rules: "required|numeric|exact_length[2]|less_than[30]|more_than[11]"
    }, {
      name: "verification_number",
      display: "Verification Number",
      rules: "required|numberic|max_length[3]"
    }
  ], displayError);
  /*
      Registration Information
  */

  return registrationValidator = new FormValidator("registration-form", [
    {
      name: "username",
      display: "Username",
      rules: "required|alpha_numeric|max_length[20]"
    }, {
      name: "password1",
      display: "Password",
      rules: "required"
    }, {
      name: "password2",
      display: "Password Confirmation",
      rules: "required|matches[password1]"
    }, {
      name: "first_name",
      display: "First Name",
      rules: "required"
    }, {
      name: "last_name",
      display: "Last Name",
      rules: "required"
    }, {
      name: "phone_number",
      display: "Phone Number",
      rules: "numeric|more_than[5]|max_length[20]"
    }, {
      name: "email",
      display: "Email Address",
      rules: "required|valid_email"
    }, {
      name: "address",
      display: "Address",
      rules: "required"
    }, {
      name: "city",
      display: "City",
      rules: "required"
    }, {
      name: "country",
      display: "Country",
      rules: "required"
    }, {
      name: "postal_code",
      display: "Postal Code",
      rules: "required|alpha_numeric"
    }, {
      name: "tos",
      display: "Term of Use",
      rules: "required"
    }
  ], displayError);
});
