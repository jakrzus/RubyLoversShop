# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminOrders', type: :system do
  let!(:admin) { create :admin_user }
  let!(:order) { create :order, :big_id }

  before do
    driven_by(:rack_test)
    create_list :order, 20
    login_admin admin
  end

  it 'allows admin to see older products by selecting different paginated pages' do
    visit admin_orders_path
    expect(find('#orders-table')).to have_no_content order.id
    find('nav.pagy-bootstrap-nav').click_on 'Next'
    expect(find('#orders-table')).to have_content order.id
  end
end
