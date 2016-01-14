class Attendance < ActiveRecord::Base
  belongs_to :patient
  belongs_to :session
end
