class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # routing error -> 404
  rescue_from ActionController::RoutingError do |exception|
    render '/public/404.html'
  end
  
  if Rails.env.production?
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionController::UnknownController, with: :render_404
      rescue_from ActionController::UnknownAction, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      
      redirect_to four_oh_four_path
    end
  end
  
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: '404.html', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
  
  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    respond_to do |format|
      format.html { render template: '505.html', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

end
