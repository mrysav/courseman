if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :file
    # TODO: S3
  end
end

if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end