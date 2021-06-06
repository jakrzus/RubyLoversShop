# frozen_string_literal: true

module Helpers
  def fill_in_sign_in_form_as(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end

  def fill_in_sign_up_form_as(user)
    fill_in_sign_in_form_as user
    fill_in 'Password confirmation', with: user.password
  end

  def log_in(user)
    post new_user_session_path, params: { user: { email: user.email, password: user.password } }
  end

  RSpec.configure do |config|
    config.include Helpers
  end
end
