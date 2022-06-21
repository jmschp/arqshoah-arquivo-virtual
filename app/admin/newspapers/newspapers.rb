# frozen_string_literal: true

ActiveAdmin.register Newspaper do
  permit_params(
    :agency_id, :author_id, :date_day, :date_month, :date_year, :description, :image, :language_id, :location,
    :pdf, :observation, :print_number, :newspaper_type_id, :title, { people_cited_ids: [] }
  )

  index do
    selectable_column
    column :registration, sortable: :id do |newspaper|
      link_to newspaper.registration, admin_newspaper_path(newspaper)
    end
    column :title
    column :date do |press|
      press.date_display(:date)
    end
    column :newspaper_type, sortable: "newspaper_type.name"
    column :agency, sortable: "agency.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string, label: "Busca geral"
  filter :title_cont, label: Newspaper.human_attribute_name(:title)
  filter :press_type, input_html: { class: "tom-select-init" }
  filter :agency, input_html: { class: "tom-select-init" }
  filter :author, input_html: { class: "tom-select-init" }
  filter :language, input_html: { class: "tom-select-init" }
  filter :date
  filter :people_cited, label: Newspaper.human_attribute_name(:people_cited), multiple: true,
                        collection: proc { Person.order(:last_name) }, input_html: { class: "tom-select-init" }
end
