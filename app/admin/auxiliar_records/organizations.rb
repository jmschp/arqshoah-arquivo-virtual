# frozen_string_literal: true

ActiveAdmin.register Organization do
  menu parent: "auxiliar_records"
  actions :all, except: [:show]

  permit_params :name, :location

  index do
    selectable_column
    column :id do |organization|
      link_to organization.id, edit_admin_organization_path(organization)
    end
    column :name
    column :city
    column :state
    column :country
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :name_cont, label: Organization.human_attribute_name(:name)

  # rubocop:disable Layout/LineLength
  form do |f|
    f.inputs do
      f.input :name
      f.input :location, as: :select, collection: [organization.location], input_html: { class: "tom-select-init location-tom-select" }
    end
    f.actions
  end
  # rubocop:enable Layout/LineLength
end
