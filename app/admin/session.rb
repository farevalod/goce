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
show do
    attributes_table do
      row "Fecha" do
		  session.date
	  end
      row "Grupo" do
		  session.group
	  end
      row :doctor
      row "Fecha de creacion" do
	    session.created_at
	  end
  	  row "Total Asistencias" do
	    session.attendances.count.to_s+"/"+session.group.patients.count.to_s+" ("+(session.attendances.count*100/session.group.patients.count).to_s+"%)"
	  end
    end
		panel "Asistencias" do
			table do
				session.attendances.each do |attendance|
					tr do
					 td link_to(attendance.patient.name, admin_attendance_path(attendance))
					 td do 
						b attendance.weight
					 end
					 td do 
						attendance.created_at.to_date
					 end
					end
				end
			end
		  end
    active_admin_comments
  end

	form :title => "Nueva Sesion" do |f|
		columns do
			column do
				f.inputs do
					f.input :group
					f.input :doctor
					f.input :date, as: :datepicker,      :input_html => { :style => "width:80px" }
					f.has_many :attendances do |a|
						a.input :patient
						a.input :weight
					end
				end
			end
			column do
				Patient.all.each do |p|
					f.semantic_fields_for "attendance[#{p.id}]",  Attendance.new do |ff|
						ff.inputs do 
							ff.input :weight,      :label => link_to(p.name, admin_patient_path(p)), :input_html => { :style => "width:80px" }
							span "Peso inicial: "+p.initial_weight.to_s
							span "Peso anterior: "+p.attendances.last.weight.to_s
							span "Diferencia de Pesos: "+(p.initial_weight-p.attendances.last.weight).to_s
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
