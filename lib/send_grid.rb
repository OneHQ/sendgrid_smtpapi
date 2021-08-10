module SendGridSmtpApi
  autoload :ApiHeader, 'send_grid/api_header'
  autoload :MailInterceptor, 'send_grid/mail_interceptor'
  autoload :VERSION, 'send_grid/version'

  def self.included(base)
    base.class_eval do
      prepend InstanceMethods
      delegate :substitute, :uniq_args, :category, :add_filter_setting, :standard_smtp, :to => :sendgrid_header
      alias_method :sendgrid_header, :send_grid_header
    end
  end

  module InstanceMethods
    def send_grid_header
      @send_grid_header ||= SendGridSmtpApi::ApiHeader.new
    end

    def mail(headers={}, &block)
      super.tap do |message|
        message.instance_variable_set :@sendgrid_header, sendgrid_header
      end
    end

    def open_tracking(enabled = true)
      add_filter_setting(:opentrack, :enable, enabled ? 1 : 0) unless enabled.nil?
    end
  end
end
