function showErrorsInForm(errors) {
  $('div.invalid-feedback').css('display', 'none')
  $('input').removeClass('is-invalid')
  for (var i = 0; i < errors.length; i++) {
    var error = errors[i]
    var key = error[0]
    var text = error[1]
    var form_error_field = $('div.form_error.' + key)
    var form_input = $('input#' + key)
    form_input.addClass('is-invalid')
    var invalid_feedback = $('div.invalid-feedback.' + key)
    invalid_feedback.css( "display", "block" );
    invalid_feedback.text(text)
  }
}
function hideErrorsInForm() {
  $('div.invalid-feedback').css('display', 'none')
  $('input').removeClass('is-invalid')
}
