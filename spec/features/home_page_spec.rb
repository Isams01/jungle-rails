require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Test Category"

    @category.products.create!(
      name: 'test product',
      description: "test product",
      image: '',
      quantity: 5,
      price: 12.50
    )
  end



  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    save_screenshot
  end

end

RSpec.feature "AddProductsToCarts", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # visit index page
    visit "/"
    # find first ad on page
    # click blue button
    expect(page).to have_css 'article.product', count: 10
    # first("article.product").find_button("Add").click
    # page.save_screenshot
    # find button with text "My Cart"
    # find_link("My Cart (1)").click
    # check that the car button quantity 1
    # click button
    # check for my cart title
    # # verify quantity # of products price
    # expect(find('header h1')).to have_content("My Cart")
    # expect(page).to have_content("TOTAL:")
  end
end