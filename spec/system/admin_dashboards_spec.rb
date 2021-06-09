# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminDashboards', type: :system do
  before do
    driven_by(:rack_test)
    create_list(:category, 3)
    create_list(:product, 5)
    visit root_path
  end

  let!(:admin) { create :admin_user }
  let(:user) { create :user }

  it 'does not allow non admin user to login to admin dashboard' do
    click_on 'Sign In'
    fill_in_sign_in_form_as user
    click_on 'Log in'
    visit admin_root_path

    expect(page).to have_content('You are not authorized')
  end

  it 'display all products if logged in as admin' do
    visit admin_root_path
    fill_in_sign_in_form_as admin
    click_on 'Log in'

    expect(page.all('.product-card').count).to eq(5)
  end
end
