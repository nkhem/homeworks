require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("boyardi", :titleize => "Boyardi") }
  subject(:brownie) { Dessert.new("brownie", 20, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eq('brownie')
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(20)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("brownie", "tons")}.to raise_error(ArgumentError)
    end

  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(brownie.ingredients).to_not include('sugar')
      brownie.add_ingredient('sugar')
      expect(brownie.ingredients).to include('sugar')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array"do
      brownie.add_ingredient('sugar')
      brownie.add_ingredient('chocolate chips')
      brownie.add_ingredient('butter')
      brownie.add_ingredient('flour')
      brownie.add_ingredient('cocoa powder')
      brownie.mix!
      expect(brownie.ingredients).to_not eq([
        'sugar',
        'chocolate chips',
        'butter',
        'flour', '
        cocoa powder'
      ])
      expect(brownie.ingredients).to include('sugar')
      expect(brownie.ingredients).to include('chocolate chips')
      expect(brownie.ingredients).to include('butter')
      expect(brownie.ingredients).to include('flour')
      expect(brownie.ingredients).to include('cocoa powder')
    end

  end

  describe "#eat" do
    it "subtracts an amount from the quantity"do
      expect(brownie.quantity).to eq(20)
      brownie.eat(4)
      expect(brownie.quantity).to eq(16)
    end

    it "raises an error if the amount is greater than the quantity"do
      expect{ brownie.eat(24) }.to raise_error
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name"do
      expect(brownie.serve.include?('Boyardi')).to be(true)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in"do
      expect(chef).to receive(:bake).with(brownie)
      brownie.make_more
    end
  end
end
