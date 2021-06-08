# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminDashboards', type: :request do
  describe 'GET /admin' do
    let!(:user) { create :user }

    it 'redirects to home page if logged in user is not an admin' do
      log_in user
      get admin_root_path

      expect(response).to redirect_to root_path
    end
  end
end
