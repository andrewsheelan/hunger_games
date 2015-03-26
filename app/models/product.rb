class Product < ActiveRecord::Base
  searchkick suggest: [:name]
  def search_data
    {
      name: name,
      description: description,
      ratings: ratings
    }
  end

  belongs_to :company
  has_attached_file :image, :styles => { :medium => "x300", :thumb => "x100" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
