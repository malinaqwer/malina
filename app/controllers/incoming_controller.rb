class IncomingController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token
  def event
    Rails.logger.log Logger::INFO, params
    render text: 'success', status: 200 # a status of 404 would reject the mail
  end
end