require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should create a product if all of the validations are true' do
    @category = Category.new(name: "Test")
    @category.save!
    @product = Product.new(name: "T-Shirt", price_cents: 2000, quantity: 10, category: @category)
    @product.save!
    expect(@product.id).to be_present
    end

    it 'should not save when name is empty' do
      @category = Category.new(name: "Test")
      @category.save!
      @product = Product.new(name: nil, price: 2000, quantity: 10, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when price is empty' do
      @category = Category.new(name: "Test")
      @category.save!
      @product = Product.new(name: "T-shirt", price: nil, quantity: 10, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when quantity is empty' do
      @category = Category.new(name: "Test")
      @category.save!
      @product = Product.new(name: "T-shirt", price: 1000, quantity: nil, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when Category is empty' do
      @product = Product.new(name: "T-shirt", price: 1000, quantity: 10, category: nil)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end