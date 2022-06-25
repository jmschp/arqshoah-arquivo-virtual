# frozen_string_literal: true

ActiveAdmin.register Education do
  includes :education_category, :venue

  permit_params(
    :description, :education_category_id, :end_date, :flyer, :observation,
    :online, :start_date, :title, :target_public, :venue_id,
    {
      images: [], organization_donor_ids: [], organizer_ids: [], person_donor_ids: [], promoter_institution_ids: [],
      teaching_material_attributes: [
        :id, :location, :pages, :pdf, :publishing_company_id, :publication_year, :recording_link, :recording_hours,
        :teaching_material_type_id, :title, :_destroy, { author_ids: [] }
      ]
    }
  )

  index do
    selectable_column
    column :registration, sortable: :id do |education|
      link_to education.registration, admin_education_path(education)
    end
    column :title
    column :education_category, sortable: "education_category.name"
    column :start_date
    column :end_date
    column :venue, sortable: "venue.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string
  filter :title_cont, label: Education.human_attribute_name(:title)
  filter :start_date
  filter :end_date
  filter :education_category, input_html: { class: "tom-select-init" }
end
