module RequestMacros
  def authenticate_user(user)
    auth_headers = user.create_new_auth_token

    age_token(user, auth_headers['client'])

    auth_headers
  end

  def age_token(user, client)
    return unless user.tokens[client]

    user.tokens[client]['updated_at'] = Time.zone.now - (DeviseTokenAuth.batch_request_buffer_throttle + 10.seconds)
    user.save!
  end

  def expire_token(user, client)
    return unless user.tokens[client]

    user.tokens[client]['expiry'] = (Time.zone.now - (DeviseTokenAuth.token_lifespan.to_f + 10.seconds)).to_i
    user.save!
  end
end