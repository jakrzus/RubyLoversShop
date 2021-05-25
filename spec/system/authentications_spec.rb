# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'
RSpec.describe 'Authentications', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:new_user) { build_stubbed :user }
  let(:existing_user) { create :user }

  it 'allows to sign up' do
    visit new_user_registration_path
    fill_in_sign_up_form_as new_user
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'allows to sign in' do
    visit new_user_session_path
    fill_in_sign_in_form_as existing_user
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'allows to reset password' do
    visit new_user_session_path
    click_on 'Forgot your password?'
    fill_in 'Email', with: existing_user.email
    click_on 'Send me reset password instructions'

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password'
  end
end
