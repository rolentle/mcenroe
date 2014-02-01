class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = User.find_or_create_by(
      uid:      auth["uid"]
    )
    user.update_attributes(
      name:          auth["info"]["nickname"],
      provider: auth["provider"],
      avatar_url:    auth["info"]["image"],
      access_token:  auth["credentials"]["token"],
      access_secret: auth["credentials"]["secret"]
    )
    user
  end
end
