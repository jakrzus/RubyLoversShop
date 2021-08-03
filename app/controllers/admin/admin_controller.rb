# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin_user!
    layout 'admin'

    def authenticate_admin_user!
      if current_user.present?
        respond_to do |format|
          format.html { redirect_to(root_path, alert: 'You are not authorized') }
          format.json { render json: { error: 'You are not authorized' } }
        end
      else
        super
      end
    end
  end
end
