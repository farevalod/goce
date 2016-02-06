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
