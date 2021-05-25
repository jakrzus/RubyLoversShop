# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'
RSpec.describe 'Authentications', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { build_stubbed :user }

  it 'allows to sign up' do
    visit new_user_registration_path
    fill_in_sign_up_form_as user
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
