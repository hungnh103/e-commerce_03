class Product < ApplicationRecord
  belongs_to :category
  has_many :specifications, dependent: :destroy, inverse_of: :product
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :specifications, reject_if: :all_blank,
    allow_destroy: true

  class << self
    def hot_trend
      date = Time.now - Settings.hot_trend.day
      product_ids = "SELECT order_details.product_id FROM order_details
        WHERE (date(order_details.created_at) > '#{date}')
        GROUP BY order_details.product_id
        ORDER BY SUM(order_details.quantity)"
      Product.where("id IN (#{product_ids})")
    end

    def import file
      spreadsheet = open_spreadsheet file
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        row = row.delete_if{|_, v| v.nil?}
        product.attributes = row.to_hash.slice *row.to_hash.keys
        product.save!
      end
    end

    def open_spreadsheet file
      case File.extname file.original_filename
      when ".csv" then Roo::Csv.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      else rails "Unknown file type: #{file.original_filename}"
      end
    end

    def to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |product|
          csv << product.attributes.values_at(*column_names)
        end
      end
    end
  end
end
