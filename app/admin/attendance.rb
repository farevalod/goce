ActiveAdmin.register Attendance do
	menu label: "Asistencia"
	#filter :patient, label: "Paciente"
	index title: "Asistencia" do
		id_column
		column :patient, label: "Paciente"
		column :session, label: "Sesion"
		column :weight, label: "Peso"
		actions
	end

	form title: "Nueva asistencia" do |f|
		f.semantic_errors # shows errors on :base
		f.inputs do
			f.input :patient, label: "Paciente"
			f.input :session, label: "Sesion", as: :select, collection: Session.all.map{|s| [s.group.name+" el "+s.created_at.to_date.to_s, s.id]}
			f.input :weight, label: "Peso", :input_html => { :style => "width:100px" }
			f.input :justificacion
		end
		f.actions         # adds the 'Submit' and 'Cancel' buttons
	end

	show title: "Registro de asistencia" do
		attributes_table do
			row "Paciente" do
				attendance.patient.name
			end
			row "Sesion" do
				attendance.session.group.name
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
