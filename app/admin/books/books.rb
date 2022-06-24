# frozen_string_literal: true

ActiveAdmin.register Book do
  menu label: I18n.t(:collection, scope: [Book.i18n_scope, :models, Book.model_name.i18n_key])

  includes :book_category, :book_field, :publishing_company

  permit_params(
    :book_category_id, :book_field_id, :description, :edition, :isbn, :image, :language_id, :location, :observation,
    :pages, :permission_level, :pdf, :publishing_company_id, :publishing_year, :title, :subtitle,
    { author_ids: [], iconography_ids: [], people_cited_ids: [] }
  )

  controller do
    def show
      @book = Book.includes(versions: :item).find(params[:id])
      @versions = @book.versions
      @book = @book.versions[params[:version].to_i].reify if params[:version]
    end
  end

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

  show do
    columns do
      column span: 2 do
        render "admin/shared/images", { record: book }
      end
      column do
        render "admin/shared/pdf", { record: book }
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :publishing_company
          row :edition
          row :isbn
          row :book_category
          row :book_field
          row :city
          row :state
          row :country
          row :language
          row :pages
        end
      end
      column do
        panel "Versões" do
          render partial: "admin/shared/version"
        end
      end
    end

    panel Book.human_attribute_name(:authors) do
      ul do
        book.authors.each do |author|
          li "#{author.name} - #{author.model_name.human}"
        end
      end
    end

    render "admin/shared/people_cited", { record: book }

    panel Book.human_attribute_name(:iconographies) do
      div style: "display: flex; justify-content: space-around; flex-wrap: wrap;" do
        book.iconographies.each do |iconography|
          figure do
            text_node(image_tag(iconography.image.variant(resize_to_fill: [400, 300, { crop: :attention }])))
            figcaption link_to(iconography.title, admin_iconography_path(iconography)), style: "text-align: center;"
          end
        end
      end
    end

    render "admin/shared/extra_info", { record: book }

    active_admin_comments
  end
end
