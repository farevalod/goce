ActiveAdmin.register Attendance do
	menu label: "Asistencia"
	filter :patient, label: "Paciente"
	filter :session, label: "Sesion"
	filter :weight, label: "Peso"
	filter :justificacion
	index title: "Asistencias" do
		id_column
		column "Paciente" do |a|
			link_to a.patient.name, admin_patient_path(a.patient)
		end
		column "Sesion" do |a|
			link_to a.session.name, admin_session_path(a.session)
		end
		column "Peso" do |a|
			a.weight
		end
		actions
	end

	form title: "Nueva asistencia" do |f|
		f.semantic_errors # shows errors on :base
		f.inputs do
			f.input :patient, label: "Paciente", as: :select2
			f.input :session, label: "Sesion", as: :select, collection: Session.all.map{|s| [s.group.name+" el "+s.created_at.to_date.to_s, s.id]}
			f.input :weight, label: "Peso", :input_html => { :style => "width:100px" }
			f.input :justificacion
		end
		f.actions         # adds the 'Submit' and 'Cancel' buttons
	end

	show title: "Registro de asistencia" do
		attributes_table do
			row "Paciente" do
				link_to attendance.patient.name, admin_patient_path(attendance.patient)
			end
			row "Sesion" do
				link_to attendance.session.group.name+" el "+attendance.session.date.to_s, admin_session_path(attendance.session)
			end
			if attendance.justificacion
				row "Justificacion" do
					"Inasistencia justificada"
				end
			else
				row "Peso" do
					attendance.weight.to_s+" Kg"
				end
			end
		end
		active_admin_comments
	end

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	permit_params :patient_id, :session_id, :weight, :justificacion
	#
	# or
	#
	# permit_params do
	#   permitted = [:permitted, :attributes]
	#   permitted << :other if resource.something?
	#   permitted
	# end



end
