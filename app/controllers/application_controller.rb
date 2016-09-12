class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  before_action :get_ip
  include Api::PicturesHelper

  def logged_in?
    !!current_user
  end

  def redirect_users
    redirect_to new_user_session_path, notice: 'Please log in first' unless logged_in?
  end

  def get_ip
    ip = request.remote_ip ? request.remote_ip : 'unknown'
    data = request.env["HTTP_USER_AGENT"] << ' - ' << ip
    AdminMailer.notify_message('got request from ', data).deliver if new_request(ip)
    unless [Rails.application.secrets.whitelist_ip,'127.0.0.1'].include?(ip)
      uAgent = request.env["HTTP_USER_AGENT"] ? request.env["HTTP_USER_AGENT"] : 'unknown'
      url = request.original_url
      @audit = Audit.new(ip: ip, country: 'local', user_agent: uAgent, url: url)
      @audit.save
    end
  end

  def new_request(ip)
    result = Audit.where(ip: ip).where("created_at >= ?", Time.zone.now.beginning_of_day)
    return !result
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def connect
    connect_to_storage
  end
end
