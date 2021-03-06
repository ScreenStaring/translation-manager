I18n.enforce_available_locales = false

redis = Redis.new(host: ENV["TRANSLATION_CACHE_HOST"])
begin
  redis.ping
  # Need to keep the original backend to support the default translations
  # expected by Rails and its dependencies
  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(redis), I18n.backend)
rescue Redis::CannotConnectError => e
  raise unless Rails.env.development?
  Rails.logger.warn("Translations will not be cached: #{e}")
end
