require "rails_helper"

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

RSpec.describe Admin::ProductsController, type: :controller do
  let(:product){mock_model Product}
  before(:each) do
    sign_in
  end

  describe "GET #index" do
    it "populates an array of products" do
      product = FactoryGirl.create :product
      get :index
      assigns(:products).should include(product)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("admin/products/index")
    end
  end

  describe "GET #edit" do
    it "should render product edit form partial" do
      response.should render_template(:partial => "product_edit_form")
      # view.should render_template(partial: "product_edit_form")
    end
  end

  describe "POST #create" do
    it "create a product successfully" do
      product_params = FactoryGirl.attributes_for(:product)
      expect{post :create, product: product_params}.to change(Product,:count).by(1)
      expect(flash[:success]).to be_present
      response.should redirect_to admin_products_url
    end

    it "create a product fail" do
      product_params = {name: nil}
      expect{post :create, product: product_params}.to change(Product,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to admin_products_url
    end
  end

  describe "PUT #update" do
    it "update a product successfully" do
      product = Product.create! FactoryGirl.attributes_for(:product)
      put :update, id: product.id, product: FactoryGirl.attributes_for(:product)
      expect(flash[:success]).to be_present
      response.should redirect_to admin_products_url
    end

    it "update a product fail" do
      product = Product.create! FactoryGirl.attributes_for(:product)
      product_params = {name: nil}
      put :update, id: product.id, product: product_params
      expect(flash[:notice]).to be_present
      response.should redirect_to admin_products_url
    end
  end

  describe "DELETE #destroy" do
    it "delete a product successfully" do
      product_params = FactoryGirl.attributes_for(:product)
      product = Product.create! product_params
      expect{delete :destroy, id: product.id}.to change(Product,:count).by(-1)
      expect(flash[:success]).to be_present
      response.should redirect_to admin_products_url
    end

    it "delete a product fail" do
      product_params = FactoryGirl.attributes_for(:product)
      product = Product.create! product_params
      Product.any_instance.stub(:destroy).and_return(false)
      expect{delete :destroy, id: product.id}.to change(Product,:count).by(0)
      expect(flash[:danger]).to be_present
      response.should redirect_to admin_products_url
    end
  end
end
