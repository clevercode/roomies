class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def handle
    logger.info "OOOOOHHH PARAMS"
    logger.info params

  end
end
