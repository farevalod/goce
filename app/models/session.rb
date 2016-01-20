class Session < ActiveRecord::Base
  belongs_to :group
  has_and_belongs_to_many :doctors
  has_many :attendances
  accepts_nested_attributes_for :attendances, :allow_destroy => true
end
