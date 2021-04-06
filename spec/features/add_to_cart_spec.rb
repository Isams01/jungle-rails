require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

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

  scenario "They can add Items to cart" do
    # visit index page
    visit "/"
    
    # verify cart is empty and there are 10 elements on page
    expect(find('ul.nav:nth-child(2) > li:nth-child(4) > a:nth-child(1)')).to have_content("My Cart (0)")
    expect(page).to have_css 'article.product', count: 10

    # add item to cart
    first("article.product").find_button("Add").click
    # check that cart was updated
    expect(find('ul.nav:nth-child(2) > li:nth-child(4) > a:nth-child(1)')).to have_content("My Cart (1)")
    # find button with text "My Cart (1)"
    find_link("My Cart (1)").click
    
    # Verify we are on cart page with one item selected
    expect(find('header h1')).to have_content("My Cart")
    expect(page).to have_content("TOTAL:")
    expect(find('tfoot').find('tr')).to have_content("$64.99");
    expect(page).to have_current_path('/cart')
  end
end
