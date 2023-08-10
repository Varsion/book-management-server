class ApplicationController < ActionController::API
  before_action :set_default_response_format
  include ErrorHandler

  private

  def set_default_response_format
    request.format = :json
  end
end
