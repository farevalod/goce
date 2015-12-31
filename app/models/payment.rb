class Payment < ActiveRecord::Base
  belongs_to :patient
end
