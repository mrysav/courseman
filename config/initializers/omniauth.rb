Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'],
  {
      :image_aspect_ratio => "square",
      :image_size => 512,
      :hd => ENV['GOOGLE_DOMAIN'],
      :prompt => "select_account"
  }
  provider :identity, :fields => [:name, :email, :image], on_failed_registration: lambda { |env|    
    SessionsController.action(:register).call(env)
  }
end
