if Rails.env.development?
  ENV['ACTIVE_ADMIN_USERNAME'] = 'test'
  ENV['ACTIVE_ADMIN_PASSWORD'] = 'test'
end
