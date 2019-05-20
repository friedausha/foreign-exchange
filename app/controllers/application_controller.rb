class ApplicationController < ActionController::Base
before_action :allow_cross_domain_ajax
  def allow_cross_domain_ajax
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = 'POST, OPTIONS'
  end
end
