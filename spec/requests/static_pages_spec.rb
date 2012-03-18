require 'spec_helper'


describe "Static Pages" do
subject { page }  
  let(:base_title) {"Ruby on Rails"}
  describe "Home page" do
    before {visit root_path}
    it { should have_selector('title',
                                :text=>"#{base_title}")}
    
  
  
    
    it {should_not have_selector('title',
                                :text=>"Home")}
    
    
  
    
    it {should have_selector('h1',
                                 :text=>'Welcome to the Sample App')}
    
    
    it {should have_selector('li',
                                :text=>'About')}
    
  end
  
  describe "Help page" do
    it "should have title help" do
      visit help_path
   page.should have_selector('title',
                                :text=>"#{base_title} | Help")

    end
  end
  
  
  describe "About page" do
    it "should have title about" do
      visit about_path
      page.should have_selector('title',
                                :text=>"#{base_title} | About")

    end
  end
  
  describe "Contact Page" do
    it "should have Contact header" do
      visit contact_path
      page.should have_selector('h1',
                                :text=>'Contact')
    end
    
     it "should have title Contact" do
      visit contact_path
      page.should have_selector('title',
                                :text=>"#{base_title} | Contact")

    end
  end
  
  
  it "should have right links in layout" do
    visit root_path
    click_link "About"
    page.should have_selector('title',text:'About')
  end
  
end
