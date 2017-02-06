require "rails_helper"

RSpec.describe Product, type: :model do
  describe "product db schema" do
    context "columns" do
      it{should have_db_column(:name).of_type(:string)}
      it{should have_db_column(:description).of_type(:text)}
      it{should have_db_column(:price).of_type(:float)}
      it{should have_db_column(:quantity).of_type(:integer)}
      it{should have_db_column(:image).of_type(:string)}
      it{should have_db_column(:category_id).of_type(:integer)}
    end
  end

  describe "test internal model" do
    subject{FactoryGirl.create :product}
    it{is_expected.to be_valid}

    context "relationship" do
      it{is_expected.to have_many :specifications}
      it{is_expected.to have_many :comments}
      it{is_expected.to have_many :order_details}
      it{is_expected.to belong_to :category}
    end

    context "validates" do
      it{expect validate_presence_of :name}
      it{expect validate_presence_of :quantity}
      it{expect validate_presence_of :price}
    end
  end

  describe "nested attributes" do
    subject {FactoryGirl.create :product}
    it "reject nested attributes" do
      product_params = FactoryGirl.attributes_for(:product)
      specifications_attributes = [{feature_name: "example", feature_value: ""}]
      product_params[:specifications_attributes] = specifications_attributes
      product = Product.create product_params
      expect(product.specifications).not_to be_present
    end
  end

  describe "product method" do
    it "import product" do
      before = Product.all.count
      file = File.open("/home/nguyenhuyhung/Downloads/product.csv", "r")
      Product.import file
      after = Product.all.count
      expect(after).to be > before
    end
  end
end
