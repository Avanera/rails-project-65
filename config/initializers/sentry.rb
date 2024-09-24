# frozen_string_literal: true

Sentry.init do |_config|
  Sentry.init do |config|
    config.dsn = Rails.application.credentials.sentry_dsn
    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    config.enabled_environments = %i[production]

    config.excluded_exceptions += [
      'ActionController::RoutingError',
      'ActionController::UnknownFormat',
      'ActiveRecord::RecordNotFound',
      'Pundit::NotAuthorizedError'
    ]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for tracing.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0
    # or
    config.traces_sampler = lambda do |_context|
      true
    end
    # Set profiles_sample_rate to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    config.profiles_sample_rate = 1.0
  end
end
