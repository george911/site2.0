class Job < ActiveRecord::Base
  letsrate_rateable "job_rating"
  has_many :bosses, :dependent => :destroy
  has_many :subordinates, :dependent => :destroy
  has_many :experiences, :dependent => :destroy
  has_many :line_items
  has_many :comments
  accepts_nested_attributes_for :bosses,:subordinates,:line_items, :comments, allow_destroy: true,reject_if: proc { |attributes| attributes[:title].blank? }
  accepts_nested_attributes_for :experiences,allow_destroy: true,reject_if: proc { |attributes| attributes[:skill].blank? }

end
