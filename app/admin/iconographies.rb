# frozen_string_literal: true

ActiveAdmin.register Iconography do
  permit_params(
    :author_id, :date_day, :date_month, :date_year, :description, :donor_id, :donor_type, :iconography_technic_id,
    :iconography_support_id, :iconography_type_id, :image, :location, :observation, :original, :subtitle, :title,
    { people_cited_ids: [] }
  )

  controller do
    def show
      @iconography = Iconography.includes(versions: :item).find(params[:id])
      @versions = @iconography.versions
      @iconography = @iconography.versions[params[:version].to_i].reify if params[:version]
    end
  end

  index do
    selectable_column
    column :registration, sortable: :id do |iconography|
      link_to iconography.registration, admin_iconography_path(iconography)
    end
    column :title
    column :date do |iconography|
      iconography.date_display(:date)
    end
    column :iconography_technic, sortable: "iconography_technic.name"
    column :iconography_type, sortable: "iconography_type.name"
    column :iconography_support, sortable: "iconography_support.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string, label: "Busca geral"
  filter :title_cont, label: Iconography.human_attribute_name(:title)
  filter :iconography_technic, input_html: { class: "tom-select-init" }
  filter :iconography_type, input_html: { class: "tom-select-init" }
  filter :iconography_support, input_html: { class: "tom-select-init" }
  filter :author, input_html: { class: "tom-select-init" }
  filter :date
  filter :people_cited, label: "Pessoas citadas", multiple: true, collection: proc { Person.order(:last_name) },
                        input_html: { class: "tom-select-init" }

  show do
    h2 iconography.subtitle
    columns do
      column span: 3 do
        panel "Imagens do Arquivo", class: "admin-show-image" do
          link_to rails_blob_path(iconography.image, disposition: "inline"), target: :_blank,
                                                                             rel: :noopener do
            image_tag iconography.image
          end
        end
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :iconography_technic
          row :iconography_type
          row :iconography_support
          row("Natureza do objeto") { iconography.original ? "Original" : "Réplica" }
          row :city
          row :state
          row :country
          row(:date) { iconography.date_display(:date) }
          row :author
          row :donor
        end
      end
      column do
        panel "Versões" do
          render partial: "admin/shared/version"
        end
      end
    end

    panel Iconography.human_attribute_name(:people_cited) do
      columns do
        column do
          panel Survivor.model_name.human do
            table_for iconography.survivors_citations do
              column :name
            end
          end
        end
        column do
          panel Savior.model_name.human do
            table_for iconography.savior_citations do
              column :name
            end
          end
        end
        column do
          panel Commoner.model_name.human do
            table_for iconography.commoners_citations do
              column :name
            end
          end
        end
      end
    end

    panel Archive.human_attribute_name(:description) do
      iconography.description
    end
    panel Archive.human_attribute_name(:observation) do
      iconography.observation
    end

    active_admin_comments
  end

  form partial: "form"
end
