module ApplicationHelper
  def full_title page_title = ""
    base_title = "E-Commerce"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def create_index object, index, per_page
    (object.to_i - 1) * per_page + index + 1
  end
end
