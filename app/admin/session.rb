ActiveAdmin.register Session do

menu label: "Sesion"
index title: "Sesion"
#
permit_params :group_id, :doctor_id, :date, :attendance
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
	form :title => "Nueva Sesion" do |f|
		columns do
			column do
				f.inputs do
					f.input :group
					f.input :doctor
					f.input :date, as: :datepicker,      :input_html => { :style => "width:80px" }
				end
			end
			column do
				Patient.all.each do |p|
					f.semantic_fields_for "attendance[#{p.id}]",  Attendance.new do |ff|
						ff.inputs do 
							ff.input :patient, selected: p.id
							ff.input :weight,      :input_html => { :style => "width:80px" }
						end
					end
				end
			end
		end
		f.actions         # adds the 'Submit' and 'Cancel' buttons
	end
	controller do
		def permitted_params
			params.permit :session, :commit, :utf8, :authenticity_token, :group_id, :doctor_id, :date, attendance: [:patient_id, :weight, :session_id]
		end
		def create
			p params
			@session = Session.new(group_id: params[:session][:group_id], doctor_id: params[:session][:doctor_id], date: params[:session][:date])
			if @session.save
				params[:session][:attendance].each do |p|
					@a = Attendance.new(patient_id: p[1][:patient_id], weight: p[1][:weight], session_id: @session.id)
					@a.save
				end
				redirect_to collection_path
			end
		end
	end
end
