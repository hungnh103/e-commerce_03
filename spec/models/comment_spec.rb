require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "comment db schema" do
    context "column" do
      it{expect have_db_column(:content).of_type(:text)}
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:product_id).of_type(:integer)}
    end
  end

  describe "validate internal model" do
    subject{FactoryGirl.create :comment}
    context "association" do
      it{is_expected.to belong_to :product}
      it{is_expected.to belong_to :user}
    end
  end
end
