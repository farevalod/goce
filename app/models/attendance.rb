class Attendance < ActiveRecord::Base
  belongs_to :patient
  belongs_to :session
  def name
	  session.group.name+" el "+session.date.to_s
  end
end
