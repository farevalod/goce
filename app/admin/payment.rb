ActiveAdmin.register Payment do
  menu label: "Pagos"
  index title: "Pagos"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :patient_id, :amount, :details, :adjustment
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form do |f|
  f.semantic_errors # shows errors on :base
  f.inputs do
	f.input :patient
	f.input :amount
	f.input :details
	f.input :adjustment, label: "Ajuste"
  end
  f.actions         # adds the 'Submit' and 'Cancel' buttons
end

show title: proc{|payment| "Pago "+payment.id.to_s+" de "+payment.patient.name } do
	attributes_table do
		row :patient
		row :amount
		row :details
		row "Ajuste" do 
			payment.adjustment
		end
    end
    active_admin_comments
end

end
