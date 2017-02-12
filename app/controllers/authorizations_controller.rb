class AuthorizationsController < ApplicationController
  def new
    redirect_to '/auth/fitbit'
  end

  def create
    authorization = Authorization.new(authorization_params)
    if authorization.save
      @provider = authorization.provider
    else
      if authorization.errors.added? :auth_user_id, :taken
        render :failure
      else
        redirect_to failure_path
      end
    end
  end

  def failure
  end

  def steps
    authorization = Authorization.first
    refresh_token authorization
    client = create_client authorization.access_token
    reply = { total_steps: total_steps_since_date(client, '2017-02-08') };
    render :json => reply.to_json
  end

  private

    # Create and return a client object
    def create_client(token)
      client = FitgemOauth2::Client.new({client_id: ENV['fitbit_client_id'], 
                                          client_secret: ENV['fitbit_client_secret'], 
                                          token: token})
    end

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

    # Return a hash of authorization params
    def authorization_params
      auth_hash = request.env['omniauth.auth']
      credentials = auth_hash['credentials']
      parameters = { access_token: credentials['token'],
                      refresh_token: credentials['refresh_token'],
                      expires_at: credentials['expires_at'],
                      auth_user_id: auth_hash['extra']['raw_info']['user']['encodedId'],
                      provider: params['provider'] }
    end

    # Refresh access token
    def refresh_token(authorization)
      time = Time.now.to_i
      if authorization.expires_at - time > 10
        return authorization
      end
      client = create_client authorization.access_token
      result = client.refresh_access_token(authorization.refresh_token)
      authorization.access_token = result['access_token']
      authorization.refresh_token = result['refresh_token']
      authorization.expires_at = time + result['expires_in'].to_i
      authorization.save
      return authorization
    end
end
