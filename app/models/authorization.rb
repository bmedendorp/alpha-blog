class Authorization < ActiveRecord::Base
  validates :access_token, presence: true
  validates :refresh_token, presence: true
  validates :expires_at, presence: true
  validates :auth_user_id, presence: true
  validates :provider, presence: true

  # Validate unique auth_user_id / provider combination
  validates_uniqueness_of :auth_user_id, scope: :provider
end