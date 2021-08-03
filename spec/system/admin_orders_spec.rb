# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'
require 'selenium-webdriver'

RSpec.describe 'AdminOrders', type: :system do
  let!(:admin) { create :admin_user }
  let!(:order) { create :order, :big_id }

  before do
    driven_by(:rack_test)
    login_admin admin
  end

  it 'allows admin to see older products by selecting different paginated pages' do
    create_list :order, 20
    visit admin_root_path
    find('nav.navbar').click_on 'Orders'
    expect(find('div.page-header')).to have_content 'Table of Orders'
    expect(find('#orders-table')).to have_no_content order.id
    find('nav.pagy-bootstrap-nav').click_on 'Next'
    expect(find('#orders-table')).to have_content order.id
  end

  it 'allows admin to enter the order page from the orders list and see all order details' do
    visit admin_root_path
    find('nav.navbar').click_on 'Orders'
    find('#orders-table').click_on order.id.to_s

    expect(page).to have_content 'Order Details'
    expect(page).to have_content order.id.to_s
    expect(page).to have_content order.state
    expect(page).to have_content order.user.email
    expect(page).to have_content order.created_at.strftime('%F %R')
  end

  it 'allows admin to change payment status to completed' do
    driven_by(:selenium_headless)
    login_admin admin
    visit admin_root_path
    find('nav.navbar').click_on 'Orders'
    find('#orders-table').click_on order.id.to_s
    click_button 'Change payment status'
    choose 'event_complete'
    click_button 'Save'

    expect(page).to have_content 'Payment status: completed'
  end

  it 'allows admin to change shipment status to shipped' do
    driven_by(:selenium_headless)
    login_admin admin
    visit admin_root_path
    find('nav.navbar').click_on 'Orders'
    find('#orders-table').click_on order.id.to_s
    click_button 'Change shipment status'
    choose 'event_prepare'
    click_button 'Save'
    click_button 'Change payment status'
    choose 'event_complete'
    click_button 'Save'
    click_button 'Change shipment status'
    choose 'event_ship'
    click_button 'Save'

    expect(page).to have_content 'Shipment status: shipped'
  end
end
