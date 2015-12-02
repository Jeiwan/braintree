class PaymentsController < ApplicationController
  def index
  end

  def token
    render json: { token: Braintree::ClientToken.generate }
  end

  def checkout
    raise StandardError, 'Missing nonce' unless params[:payment_method_nonce].present?
    raise StandardError, 'Missing amount' unless params[:amount].present?

    result = Braintree::Transaction.sale(
      amount: params[:amount],
      payment_method_nonce: params[:payment_method_nonce]
    )

    if result.success?
      redirect_to payments_path, notice: 'Successful payment'
    else
      if result.errors.size > 0
        message = result.errors.map { |e| e.message }.join(', ')
      else
        message = case result.transaction.status
        when 'processor_declined'
          'Processor declined the payment. Try again in a minute'
        when 'gateway_rejected'
          'Gateway rejected the payment.'
        end
      end

      redirect_to payments_path, alert: message
    end
  end
end
