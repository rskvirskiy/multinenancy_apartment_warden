require 'rails_helper'

describe 'the signin process', type: :feature do
  let(:correct_password) { 'welcome123' }
  let(:email) { 'test_tenant@example.com' }

  before(:each) do
    create(:tenant, email: email, password: correct_password, password_confirmation: correct_password)
  end

  context 'correct credentials' do
    describe 'Sign in should be succeed' do
      it do
        visit new_tenants_sessions_path

        within('#session') do
          fill_in 'Email', with: email
          fill_in 'Password', with: correct_password
        end

        click_button 'Sign in'
        expect(page).to have_content 'Tenant sign in success'
      end
    end
  end

  context 'incorrect credentials' do
    describe 'Sign in should be failed' do
      it 'sign in' do
        visit new_tenants_sessions_path

        within('#session') do
          fill_in 'Email', with: email
          fill_in 'Password', with: 'wrong password'
        end

        click_button 'Sign in'
        expect(page).to_not have_content 'Success'
      end
    end
  end
end