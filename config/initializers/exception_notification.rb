require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  # Adds a condition to decide when an exception must be ignored or not.
  # The ignore_if method can be invoked multiple times to add extra conditions.
  config.ignore_if do |_exception, _options|
    Rails.env.development?
  end

  # Notifiers =================================================================

  # Email notifier sends notifications by email.
  if Rails.application.secrets.dig :slack, :url
    config.add_notifier :slack,
                        webhook_url: Rails.application.secrets.slack[:url],
                        channel: '#exceptions',
                        additional_parameters: {
                          mrkdwn: true
                        }
  end
end
