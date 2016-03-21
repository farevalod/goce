ActiveAdmin.register Session do

menu label: "Sesiones"
index title: "Sesiones" do
	column "Nombre" do |s|
		link_to(s.name, admin_session_path(s))
	end
	column :date
	column :group
	column :doctors do |s|
	  s.doctors.map{|d| link_to(d.name, admin_doctor_path(d))}.join(", ").html_safe
	end
end
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
      row :doctor do
		  session.doctors.map{|d| link_to(d.name, admin_doctor_path(d))}.join(", ").html_safe
	  end
      row "Fecha de creacion" do
	    session.created_at
	  end
  	  row "Total Asistencias" do
		  if session.group.patients.count > 0
			session.attendances.count.to_s+"/"+session.group.patients.where("patients.status = 1").count.to_s+" ("+(session.attendances.count*100/session.group.patients.where("patients.status = 1").count).to_s+"%)"
		  end
	  end
    end
		panel "Asistencias" do
			table do
				session.attendances.each do |attendance|
					if attendance.weight > 0 or attendance.justificacion
						tr do
						 td link_to(attendance.patient.name, admin_attendance_path(attendance))
						 td do 
							 if attendance.weight == 0
								 b "Justificado"
							 else
								b attendance.weight
							 end
						 end
						 td do 
							attendance.created_at.to_date
						 end
						end
					end
				end
				session.group.patients.where("patients.status = 1").each do |p|
					if not session.attendances.map{ |a| a.patient_id }.include?(p.id)
						tr :style => "background:#d99" do
						 td link_to(p.name, admin_patient_path(p))
						 td do 
							 b "Ausente"
						 end
						 td do 
							session.created_at.to_date
						 end
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
					f.input :group, label: "Grupo", as: :select2
				    f.input :doctors, :as => :select2_multiple, :input_html => {:multiple => true}, label: "Terapeuta(s)"
					f.input :date, as: :datepicker, :input_html => { :style => "width:80px" }, label: "Fecha"
				end
			end
			column do
				if params[:group_id]
					patients = Patient.includes(:groups).where("groups.id = ?", params[:group_id]).references(:groups)
				else
					patients = Patient.all
				end
				patients.each do |pa|
					if pa.balance < 0
						color = "#f00"
					end
					f.semantic_fields_for "attendance[#{pa.id}]",  Attendance.new do |ff|
						ff.inputs do 
							if !pa.attendances.empty?
								ff.input :weight, :label => link_to(pa.name, admin_patient_path(pa)), :input_html => { :style => "width:80px" }, :hint => "Peso anterior: "+pa.attendances.last.weight.to_s+", Peso inicial: "+pa.initial_weight.to_s+", Diferencia de Pesos: "+(pa.initial_weight-pa.attendances.last.weight).to_s
							else
								ff.input :weight, :label => link_to(pa.name, admin_patient_path(pa)), :input_html => { :style => "width:80px" }, :hint => "Peso inicial: "+pa.initial_weight.to_s
							end
							ff.input :justificacion
						end
					end
				end
				f.has_many :attendances, heading: "Asistencias de otros grupos", new_record: "Agregar Paciente..." do |a|
					a.input :patient_id, label: "Paciente", as: :select2, :collection => Patient.all.map{|p| ["#{p.name}, #{p.rut}", p.id]}
					a.input :weight, label: "Peso", :input_html => { :style => "width:80px" }
					a.input :justificacion
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
			@session = Session.new(group_id: params[:session][:group_id], date: params[:session][:date])
			params[:session][:doctor_ids].each do |d|
				if !d.empty?
					@session.doctors << Doctor.find(d)
				end
			end
			if @session.save
				params[:session][:attendance].each do |p|
					if (!p[1][:weight].empty?) or (p[1][:justificacion] == "1")
						@a = Attendance.new(patient_id: p[0], weight: p[1][:weight].to_i, justificacion: p[1][:justificacion], session_id: @session.id)
						@a.save
					end
				end
				redirect_to collection_path
			end
		end
	end
end
