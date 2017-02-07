require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "all static pages" do
    it "render #home page" do
      get :show, page: "home"
      expect(response).to render_template :home
    end

    it "render #help page" do
      get :show, page: "help"
      expect(response).to render_template :help
    end

    it "render #about page" do
      get :show, page: "about"
      expect(response).to render_template :about
    end

    it "render #contact page" do
      get :show, page: "contact"
      expect(response).to render_template :contact
    end

    it "render 404 not found page" do
      get :show, page: "other"
      expect(response).to render_template file: "#{Rails.root}/public/404.html"
    end
  end
end
