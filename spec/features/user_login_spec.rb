require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!(
      first_name: "test_user",
      last_name: "lname",
      email: "test@test.com",
      password: "test",
      password_confirmation: "test"
    )
  end

  scenario "A user can succesfully login" do
    visit "/login"

    fill_in('email', :with => 'test@test.com')
    fill_in('password', :with => 'test')
    click_button("Submit")
    expect(page).to have_content("test_user")
    page.save_screenshot

  end

  scenario "A user cannot login with the wrong credentials" do
    visit "/login"

    fill_in('email', :with => 'abcdefg@test.com')
    fill_in('password', :with => 'test')
    click_button("Submit")
    expect(find("main.container > h1:nth-child(1)")).to have_content("Login")
    expect(find("ul.nav:nth-child(2) > li:nth-child(1) > a:nth-child(1)")).to have_content("Login")
    expect(find_field("email")).to have_content("")
    expect(page).to have_field('email', with: '')
    expect(page).to have_field('password', with: 'abc')
  end
end
