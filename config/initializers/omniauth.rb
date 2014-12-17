Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'],
  {
      :image_aspect_ratio => "square",
      :image_size => 512,
      :hd => "d.umn.edu"
  }
end