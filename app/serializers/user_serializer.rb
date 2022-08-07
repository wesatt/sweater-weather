# frozen_string_literal: true

class UserSerializer
  def self.format_user(user, api_key)
    {
      data: {
        id: user.id,
        type: 'users',
        attributes: {
          email: user.email,
          api_key: api_key.token
        }
      }
    }
  end
end
