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

  # Hack to prevent default link follow click through so we
  # can call noty confirmation to follow the link through.
  $(".delete, .confirm").live 'click', ->
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

################################################################################
# Validator Error Handler
################################################################################

  displayError = (errors, event, confirmMsg = "Proceed to submit?") ->
    if errors.length > 0
      errorString = ""
      for error in errors
        noteAlert error.message, "warning"
    else
      if confirmMsg?
        if confirm confirmMsg then true else false


  ###
    Login Form Validator
  ###
  confirmMsg = "Proceed to sign in?"

  loginValidator = new FormValidator("login-form", [{
      name: 'username',
      rules: 'required|max_length[30]'
    }, {
      name: 'password',
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

