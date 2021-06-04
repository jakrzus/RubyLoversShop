# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin_user!
    layout 'admin'
    def authenticate_admin_user!
      current_user.present? ? redirect_to(root_path, alert: 'You are not authorized') : super
    end
  end
end
