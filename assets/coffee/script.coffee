###
Do NOT modify .js file, modify only the .coffee file 
This script is used for data validation, and ajax.
This script is NOT for UI, or animation, do that in global-script instead.
###

$ ->
  $('.tiptip a.button, .tiptip button').tipTip()

  # Submit button checking
  $(".submit, .delete").click ->
    if confirm "Ready to submit?"
      $.submit


	