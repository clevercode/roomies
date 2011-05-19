class PaymentsController < ApplicationController
  def handle
    logger.info params
  end
end
