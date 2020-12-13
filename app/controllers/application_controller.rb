class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def render_404
    @error = true
    render template: 'errors/error_404', status: 404, content_type: 'text/html'
  end

  def render_500
    @error = true
    render template: 'errors/error_500', status: 500, content_type: 'text/html'
  end
end
