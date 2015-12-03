require 'rails_helper'

describe 'user login process' do
  let(:subdomain1) { 'tenant1' }
  let(:subdomain2) { 'tenant2' }

  let(:password) { 'welcome' }
  let(:email) { 'user@mail.com' }

  before(:each) {
    create(:tenant, name: subdomain1)
    create(:tenant, name: subdomain2)

    Apartment::Tenant.switch!(subdomain1)
    create(:user, password: password, password_confirmation: password, email: email)

    Apartment::Tenant.switch!('public')
  }

  context 'without subdomain' do
    it 'should not login user' do
      visit new_users_sessions_path

      within('#session') do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
      end

      click_button 'Sign in'

      expect(page).to have_content 'Wrong credentials'
    end
  end

  context 'with correct subdomain' do
    it 'should login user' do
      switch_to_subdomain(subdomain1)
      visit new_users_sessions_path

      within('#session') do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
      end

      click_button 'Sign in'

      expect(page).to have_content "User login for #{email} success"
    end
  end

  context 'with incorrect subdomain' do
    it 'should login user' do
      switch_to_subdomain(subdomain2)
      visit new_users_sessions_path

      within('#session') do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
      end

      click_button 'Sign in'

      expect(page).to have_content 'Wrong credentials'
    end
  end
end