class AuthorizationsController < ApplicationController
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
    @total_steps = total_steps_since_date(client, '2017-02-09');
    @info = client.refresh_access_token(refresh_token)
  end

  def failure
  end

  private

    # Return the total steps taken AFTER (since) the specified date
    def total_steps_since_date(client, date)
      date = Date.parse(date) + 1
      activity_steps = client.activity_time_series resource: 'steps', start_date: date, end_date: 'today'
      total_steps = 0
      activity_steps['activities-steps'].each do |day|
        total_steps += day['value'].to_i
      end
      return total_steps
    end
end
