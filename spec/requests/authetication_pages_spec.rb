require 'spec_helper'
describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1', text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid info" do
      before { click_button "Sign in" }
      
      it {should have_selector('title', text: 'Sign In')}
      it {should have_selector('div.alert.alert-error', text: 'Invalid')}
      
      describe "if visit another page, should not see flash" do
        before { click_link 'Home' }
        it { should_not have_selector('div.alert.alert-error')}
      end
    end
    
    
    
    describe "with valid info" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      
      it { should have_selector('title', text: user.name) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "test links" do
        before { click_link "Home" }
        it { should have_link('Sign Out') }
      end
      describe "sign out" do
        before do
          click_link "Sign Out"
        end
        
        it { should have_link('Sign in') }
      end
      
      
    end
    
    describe "with 5 failed attempts" do
      let(:user) { FactoryGirl.create(:user, failed_password_attempts:4) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: '123'
        click_button "Sign in"
        user.reload.failed_password_attempts
        
      end
      it { should have_content('Too many failed attempts')}
      specify { user.reload.failed_password_attempts  == 5 }
    end
    
    describe "after 5 failed attempts" do
      let(:user) { FactoryGirl.create(:user, failed_password_attempts:6) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: '123'
        click_button "Sign in"
        user.reload.failed_password_attempts
        
      end
      it { should have_content('Too many failed attempts')}
      it { should have_content(user.email)}
      specify { user.reload.failed_password_attempts  == 7 }
    end
    
  end
end
