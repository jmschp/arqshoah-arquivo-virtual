# frozen_string_literal: true

ActiveAdmin.register Book do
  menu label: I18n.t(:collection, scope: [Book.i18n_scope, :models, Book.model_name.i18n_key])

  includes :book_category, :book_field, :publishing_company

  permit_params(
    :book_category_id, :book_field_id, :description, :edition, :isbn, :image, :language_id, :location, :observation,
    :page_number, :permission_level, :pdf, :publishing_company_id, :publishing_year, :title, :subtitle,
    { author_ids: [], iconography_ids: [], people_cited_ids: [] }
  )

  index do
    selectable_column
    column :registration, sortable: :id do |book|
      link_to book.registration, admin_book_path(book)
    end
    column :title
    column :publishing_year
    column :book_category, sortable: "book_category.name"
    column :book_field, sortable: "book_field.name"
    column :publishing_company, sortable: "publishing_company.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string
  filter :title_or_subtitle_cont, label: Book.human_attribute_name(:title)
  filter :publishing_company, input_html: { class: "tom-select-init" }
  filter :book_category, input_html: { class: "tom-select-init" }
  filter :book_field, input_html: { class: "tom-select-init" }
  filter :authors, multiple: true, input_html: { class: "tom-select-init" }
  filter :publishing_year
  filter :language, input_html: { class: "tom-select-init" }
  filter :people_cited, multiple: true, collection: proc { Person.order(:last_name) },
                        input_html: { class: "tom-select-init" }
end
