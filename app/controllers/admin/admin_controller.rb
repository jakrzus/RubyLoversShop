# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin_user!
  end
end
