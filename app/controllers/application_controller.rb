# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  layout :layout

  private

  def layout
    if devise_controller? && resource_name == :admin_user
      'admin'
    else
      'application'
    end
  end
end
