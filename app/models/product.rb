class Product < ActiveRecord::Base
  searchkick suggest: [:name]
  belongs_to :company
  has_attached_file :image, :styles => { :medium => "x300", :thumb => "x100" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :users
end
