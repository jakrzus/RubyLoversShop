# frozen_string_literal: true

module Helpers
  def fill_in_sign_up_form(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
  end

  RSpec.configure do |config|
    config.include Helpers
  end
end
