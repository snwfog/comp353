###
Do NOT modify .js file, modify only the .coffee file 
This script is used for data validation, and ajax.
This script is NOT for UI, or animation, do that in global-script instead.
###

$(document).ready ->
################################################################################
# Google+ Style Tooltips Setup
################################################################################

  $('.tiptip a.button, .tiptip button').tipTip()

################################################################################
# Noty Confirmation Setup
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
      timeout: 5000
    })

  noteConfirm = (msg, url) ->
    n = noty({
      layout: 'center',
      type: 'alert',
      text: msg,
      modal: true,
      animation: {
        open: {height: 'toggle'},
        close: {height: 'toggle'},
        easing: 'swing',
        speed: 50
      },
      buttons: [
        {
          addClass: 'btn btn-primary', text: 'Continue', onClick: ($noty) ->
            $noty.close()
            window.location = url
        },
        {
          addClass: 'btn btn-danger', text: 'Cancel', onClick: ($noty) ->
            $noty.close()
        }
      ]
    })

  noteFormConfirm = (msg, event) ->
    n = noty({
      layout: 'center',
      type: 'alert',
      text: msg,
      modal: true,
      animation: {
        open: {height: 'toggle'},
        close: {height: 'toggle'},
        easing: 'swing',
        speed: 50
      },
      buttons: [
        {
          addClass: 'btn btn-primary', text: 'Continue', onClick: ($noty) ->
            $noty.close()
        },
        {
          addClass: 'btn btn-danger', text: 'Cancel', onClick: ($noty) ->
            $noty.close()
        }
      ]
    })

  # Hack to prevent default link follow click through so we
  # can call noty confirmation to follow the link through.
  $(".delete, .confirm, .modify, .warn").live 'click', ->
    this.blur()
    false

  # Confirm delete and confirm class link with noty on click
  # Customize the msg when needed.
  $('.delete').click ->
    loc = $(this).attr "href"
    noteConfirm "Are you sure you want to perform a delete?", loc

  $('.confirm').click ->
    loc = $(this).attr "href"
    noteConfirm "Are you sure you want to accept this offer?", loc

  $('.warn').click ->
    loc = $(this).attr "href"
    noteConfirm "Are you sure to send this warning to owner?", loc

  $('.modify').click ->
    loc = $(this).attr "href"
    noteConfirm "Are you sure to modify this post?", loc

################################################################################
# Validator Error Handler
################################################################################
  displayError = (errors, event) ->
    if errors.length > 0
      errorString = ""
      for error in errors
        noteAlert error.message, "warning"
    else
      return confirm "Ready to submit your form?"

  ###
    Login Form Validator
  ###
  loginValidator = new FormValidator("login-form", [{
      name: 'username',
      display: 'Username'
      rules: 'required|max_length[30]'
    }, {
      name: 'password',
      display: 'Password',
      rules: 'required'
    }], displayError)

  ###
    Post Offer Form Validator
  ###
  postOfferValidator = new FormValidator("post-offer-form", [{
      name: "title",
      rules: "required|max_length[50]"
    }, {
      name: "category",
      rules: "required"
    }, {
      name: "price",
      rules: "required|numeric"
    }, {
      name: "description"
      rules: "required"
    }], displayError)

  ###
    Post Offer Form Validator
  ###
  postOfferValidator = new FormValidator("comment-form", [{
      name: "rating",
      display: "Rating",
      rules: "required"
    }, {
      name: "comment",
      display: "Comment",
      rules: "required"
    }], displayError)



  ###
    Bid On Offer Form Validator
  ###
  bidOfferValidator = new FormValidator("bid-offer-form", [{
    name: "category",
    rules: "required"
  }, {
    name: "price",
    rules: "required|numeric"
  }, {
    name: "description",
    rules: "required|max_length[100]"
  }], displayError)

  ###
    Credit Card Information
  ###
  creditCardValidator = new FormValidator("credit-card-form", [{
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
    rules: "required|numeric|exact_length[2]|less_than[12]|more_than[1]"
  }, {
    name: "expiration_year",
    display: "Expire Year",
    rules: "required|numeric|exact_length[2]|less_than[2030]|more_than[2012]"
  }, {
    name: "verification_number",
    display: "Verification Number",
    rules: "required|numberic|less_than[4]"
  }], displayError)

  ###
    Registration Information
  ###
  registrationValidator = new FormValidator("registration-form", [{
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
  }], displayError)