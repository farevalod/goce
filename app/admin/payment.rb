ActiveAdmin.register Payment do
  menu label: "Pagos"
  index title: "Pagos"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :patient_id, :amount, :details, :adjustment, :mes, :boleta
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form :title => "Nuevo Pago" do |f|
  f.semantic_errors # shows errors on :base
  f.inputs do
	f.input :patient, label: "Paciente", as: :select2_multiple
	f.input :amount, :input_html => { :style => "width:80px" }, label: "Monto"
	f.input :details, :input_html => { :style => "width:480px" }, label: "Detalles"
	f.input :mes, as: :select, collection: Payment.months
	f.input :boleta, class: :small, :input_html => { :style => "width:80px" }
	f.input :adjustment, label: "Ajuste de pago"
  end
  f.actions         # adds the 'Submit' and 'Cancel' buttons
end

show title: proc{|payment| "Pago "+payment.id.to_s+" de "+payment.patient.name } do
	attributes_table do
		row :patient
		row :amount do
			number_to_currency payment.amount, separator: ",", delimiter: ".", precision: 0
		end
		row :details
		if payment.adjustment
			row "Ajuste" do 
					"Si"
			end
		end
    end
    active_admin_comments
end

end
