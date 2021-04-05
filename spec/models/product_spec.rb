require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Can create a valid product' do
      @category = Category.new
      @product = Product.new(name: 'test', price: 1234, quantity: 10, category: @category)
      expect(@product).to be_valid
    end
    it 'Validates name' do
      @category = Category.new
      @product = Product.new(price: 1234, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'Validates price' do
      @category = Category.new
      @product = Product.new(name: "Hello", quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number")
      expect(@product.errors.full_messages).to include("Price is not a number")
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'Validates quantity' do
      @category = Category.new
      @product = Product.new(name: "Hello", price: 1234, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'Validates category' do
      @product = Product.new(name: "Hello", price: 1234, quantity: 10)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
