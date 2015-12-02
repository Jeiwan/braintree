$(() => {
  if (typeof braintree !== 'undefined' && $('#checkout_form').length > 0) {
    $('#payment_form_loader').removeClass('hidden');

    $.ajax({
      url: '/payments/token',
      dataType: 'json',
      method: 'GET'
    }).done(response => {
      braintree.setup(response.token, 'dropin', {
        container: 'payment_form',
        onReady: () => {
          console.log('done!');
          $('#checkout_form .form-group').removeClass('hidden');
          $('#payment_form_loader').addClass('hidden');
        }
      });
    }).fail(response => {
      console.log(response);
    });
  }
});
