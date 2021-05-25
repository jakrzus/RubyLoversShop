# frozen_string_literal: true

require 'rails_helper'
require File.expand_path('./spec/support/helpers.rb')

RSpec.describe 'Authentications', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { attributes_for :user }

  it 'allows to sign up' do
    visit new_user_registration_path
    fill_in_sign_up_form user
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
