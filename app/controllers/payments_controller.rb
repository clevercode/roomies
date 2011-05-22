class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json

  def handle
    logger.info "OOOOOHHH PARAMS"
    logger.info params
    @params = params

    respond_with @params
  end
end
