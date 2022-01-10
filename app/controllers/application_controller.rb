class ApplicationController < ActionController::API
  before_action :check_auth

  def check_auth


    puts request.headers['HTTP_AUTHORIZATION']
    render :nothing => true, :status => 403 unless request.headers['HTTP_AUTHORIZATION']
  end
end
