# frozen_string_literal: true

ActiveAdmin.register Newspaper do
  permit_params(
    :agency_id, :author_id, :date_day, :date_month, :date_year, :description, :image, :language_id, :location,
    :pdf, :observation, :print_number, :newspaper_type_id, :title, { people_cited_ids: [] }
  )

  controller do
    def show
      @newspaper = Newspaper.includes(versions: :item).find(params[:id])
      @versions = @newspaper.versions
      @newspaper = @newspaper.versions[params[:version].to_i].reify if params[:version]
    end
  end

  index do
    selectable_column
    column :registration, sortable: :id do |newspaper|
      link_to newspaper.registration, admin_newspaper_path(newspaper)
    end
    column :title
    column :date do |newspaper|
      newspaper.date_display(:date)
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

  show do
    columns do
      column span: 2 do
        panel "Imagem", class: "admin-show-image" do
          if newspaper.image.present?
            link_to rails_blob_path(newspaper.image, disposition: "inline"), target: :_blank, rel: :noopener do
              image_tag newspaper.image
            end
          else
            div class: "admin-show-image" do
              image_tag "arqshoah-logo.png"
            end
          end
        end
      end
      column do
        panel Newspaper.human_attribute_name(:pdf) do
          if newspaper.pdf.present?
            text_node link_to(
              "Abrir", rails_blob_path(newspaper.pdf, disposition: "inline"), target: :_blank, rel: :noopener
            )
            render "active_storage/blobs/blob", blob: newspaper.pdf, size: [150, 200]
          else
            text_node "sem anexo"
          end
        end
      end
      column span: 2 do
        attributes_table do
          row :registration
          row(:date) { newspaper.date_display(:date) }
          row :newspaper_type
          row :author
          row :agency
          row :city
          row :state
          row :country
          row :language
        end
      end
      column do
        panel "Versões" do
          render partial: "admin/shared/version"
        end
      end
    end

    render "admin/shared/people_cited", { record: newspaper }
    render "admin/shared/extra_info", { record: newspaper }

    active_admin_comments
  end

  form partial: "form"
end
