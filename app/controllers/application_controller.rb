class ApplicationController < ActionController::Base
  # def self.app_logo
  #   app_logo = PhotoBuilder.app_logo_info
  #   app_logo.url
  # end

  # def self.app_logo_likes
  #   app_logo = PhotoBuilder.app_logo_info
  #   app_logo.likes
  # end


  def welcome
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
