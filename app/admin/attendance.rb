ActiveAdmin.register Attendance do
	  menu label: "Asistencia"
	  index title: "Asistencia" do
	  id_column
	  column :patient
	  column :session
	  column :session do |a|
		  link_to a.session.group.name, admin_group_path(a.session.group)
	  end
	  column :weight
	  actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :patient_id, :group_id, :weight, :justificacion
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end



end
