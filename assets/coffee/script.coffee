###
Do NOT modify .js file, modify only the .coffee file 
This script is used for data validation, and ajax.
This script is NOT for UI, or animation, do that in global-script instead.
###

$ ->
  $('.tiptip a.button, .tiptip button').tipTip()

  ###
    A few button confirmation
  ###
  $('.delete').click ->
    confirmAction "Are you sure you want to perform a delete?"

  $('.confirm').click ->
    confirmAction "Are you sure you want to accept this offer?"

  confirmAction = (msg) ->
    if confirm msg then true else false

  ###
    Validator Error Handler
  ###

  displayError = (errors, event, confirmMsg = "Proceed to submit?") ->
    if errors.length > 0
      errorString = ""
      for error in errors
        errorString += "<li>#{error.message}</li>"
      $('.error-field').html errorString
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
