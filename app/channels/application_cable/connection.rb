# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      access_token = request.params['access-token']
      decoded_token = JWT.decode access_token, Rails.application.credentials.fetch(:secret_key_base), true,
                                 { algorithm: 'HS256' }
      verified_user = User.find_by(jti: decoded_token.first['jti'])
      verified_user || reject_unauthorized_connection
    end
  end
end
