# frozen_string_literal: true

ActiveAdmin.register Savior do
  permit_params(
    :academic_formation, :birth_date_day, :birth_date_month, :birth_date_year, :birth_place, :death_date_day,
    :death_date_month, :death_date_year, :death_place, :first_name, :last_name, :gender, :pdf,
    :family_members, :description, :observation, :professional_activities, :religion_id,
    { images: [] }
  )

  index do
    selectable_column
    column :registration, sortable: :id do |survivor|
      link_to survivor.registration, admin_survivor_path(survivor)
    end
    column :first_name
    column :last_name
    column :gender
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string, label: "Busca geral"
  filter :name_cont, label: Savior.human_attribute_name(:name)
  filter :birth_place_country_eq, collection: proc { Survivor.all.pluck(:birth_place_country) },
                                  label: Survivor.human_attribute_name(:birth_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :death_place_country_eq, collection: proc { Survivor.all.pluck(:death_place_country) },
                                  label: Survivor.human_attribute_name(:death_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :birth_date
  filter :death_date
  filter :religion, input_html: { class: "tom-select-init" }
end
