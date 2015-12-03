require 'rails_helper'

describe 'the register and login process', type: :feature do
  let(:password) { 'welcome123' }
  let(:email) { 'test_tenant@example.com' }
  let(:name) { 'test-tenant' }

  describe 'tenant creation process' do
    before(:each) do
      visit new_tenant_path
      Tenant.destroy_all
    end

    context 'valid name of subdomain' do
      it 'should return correct success message' do
        within('#new_tenant') do
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          fill_in 'Password confirmation', with: password
          fill_in 'Subdomain name', with: name
        end

        click_button 'Create'
        expect(page).to have_content "Tenant #{email} was created"

        click_link 'Tenant login'

        within('#session') do
          fill_in 'Email', with: email
          fill_in 'Password', with: password
        end

        click_button 'Sign in'

        expect(page).to have_content "Tenant login for #{email} success"
      end
    end

    context 'invalid name of subdomain', js: true do
      it 'should show up error message' do
        within('#new_tenant') do
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          fill_in 'Password confirmation', with: password
          fill_in 'Subdomain name', with: 'test-'
        end

        expect(page).to have_content 'cannot start or end with a hyphen'
      end
    end
  end
end