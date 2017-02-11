class SessionsController < ApplicationController
  def new
  end

  def create
    @auth_hash = request.env['omniauth.auth']
  end

  def failure
  end
end
