class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  before_action :get_ip

  def logged_in?
    !!current_user
  end

  def get_ip
    ip = request.remote_ip ? request.remote_ip : 'unknown'
    uAgent = request.env["HTTP_USER_AGENT"] ? request.env["HTTP_USER_AGENT"] : 'unknown'
    url = request.original_url
    @audit = Audit.new(ip: ip, country: 'local', user_agent: uAgent, url: url)
    @audit.save
  end
end
