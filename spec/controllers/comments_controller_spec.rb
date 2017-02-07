require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  before :each do
    sign_in
    @product = FactoryGirl.create :product
  end

  describe "POST #create" do
    it "create comment successfully" do
      comment = double(Comment)
      allow_any_instance_of(CommentsController).to receive(:create).and_return(comment)
      allow(Comment).to receive(:new).and_return(comment)
      post :create, params: {product_id: @product.slug,
        comment: {content: "example comment"}}
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "DELETE #destroy" do
    it "delete a comment successfully" do
      comment = FactoryGirl.create :comment
      comment.user = @user
      comment.product = @product
      comment.save
      delete :destroy, params: {product_id: @product.slug, id: comment.id}
      expect change(Comment, :count).by(-1)
    end

    it "delete a comment fail" do
      comment = FactoryGirl.create :comment
      comment.user = @user
      comment.product = @product
      comment.save
      allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
      delete :destroy, params: {product_id: @product.slug, id: comment.id}
      expect change(Comment, :count).by(0)
    end
  end
end
