class PaymentsController < ApplicationController
  def handle
    logger.info params
    logger.info params[:json][:event]
  end
end
