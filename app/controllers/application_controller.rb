class ApplicationController < ActionController::API
  before_action :check_auth

  def check_auth
    # decode middle jwt part
    # if iss == 'google'
      # validation with google
    # else if iss == 'microsoft'
      # validation with microsoft
    # else
      # reject w 403
    puts request.headers['HTTP_AUTHORIZATION']
    render :nothing => true, :status => 403 unless request.headers['HTTP_AUTHORIZATION']
  end
end
