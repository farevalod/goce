class Session < ActiveRecord::Base
  belongs_to :group
  belongs_to :doctor
  has_many :attendances
  accepts_nested_attributes_for :attendances, :allow_destroy => true
end
