ActiveAdmin.register Payment do
  menu label: "Pagos"
  index title: "Pagos"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :patient_id, :amount, :details
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
show title: proc{|payment| "Pago "+payment.id.to_s+" de "+payment.patient.name } do
	attributes_table do
		row :patient
		row :amount
		row :details
    end
    active_admin_comments
end

end
