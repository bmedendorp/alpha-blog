class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    credentials = auth_hash['credentials']
    token = credentials['token']
    refresh_token = credentials['refresh_token']
    client = FitgemOauth2::Client.new({client_id: ENV['fitbit_client_id'], 
                                        client_secret: ENV['fitbit_client_secret'], 
                                        token: token})
    @info = client.daily_activity_summary 'today'
    @todays_steps = @info['summary']['steps']
    @info = client.daily_activity_summary 'yesterday'
    @yesterdays_steps = @info['summary']['steps']
    @info = client.refresh_access_token(refresh_token)
  end

  def failure
  end
end
