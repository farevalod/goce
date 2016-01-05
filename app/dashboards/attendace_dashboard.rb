require "administrate/base_dashboard"

class AttendaceDashboard < Administrate::BaseDashboard

  # This method returns a hash
  # that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.

    ATTRIBUTE_TYPES = {
    id: Field::Integer,
    created_at: Field:::DateTime,
    updated_at: Field::DateTime,
    patient: Field::HasOne,
    group: Field::HasOne,
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :patient,
    :group,
    :created_at,
    :updated_at,
  ]

  # This method returns an array of attributes
  # that will be displayed on the model's index page.
  def table_attributes
    attributes
  end

  # This method returns an array of attributes
  # that will be displayed on the model's show page
  def show_page_attributes
    attributes
  end

  # This method returns an array of attributes
  # that will be displayed on the model's form pages (`new` and `edit`)
  def form_attributes
    attributes - read_only_attributes
  end

  private

  def attributes
    [
      :id,
      :patient_id,
      :group_id,
      :weight,
      :created_at,
      :updated_at,
      :patient,
      :group,
    ]
  end

  def read_only_attributes
    [
      :id,
      :created_at,
      :updated_at,
    ]
  end
end
