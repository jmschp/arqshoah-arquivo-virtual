# frozen_string_literal: true

ActiveAdmin.register Archive do
  includes :archive_type, :archive_classification

  permit_params(
    :archive_classification_id, :archive_type_id, :date_day, :date_month, :date_year, :description, :donor_id,
    :donor_type, :document_code, :document_number, :from_name, :from_role, :issuing_agency_id, :language_id,
    :location, :observation, :page_count, :pdf, :permission_level, :receiver_agency_id, :title, :to_name, :to_role,
    { images: [], people_cited_ids: [] }
  )

  controller do
    def show
      @archive = Archive.includes(versions: :item).find(params[:id])
      @versions = @archive.versions
      @archive = @archive.versions[params[:version].to_i].reify if params[:version]
    end
  end

  index do
    selectable_column
    column :registration, sortable: :id do |archive|
      link_to archive.registration, admin_archive_path(archive)
    end
    column :title
    column :date do |archive|
      archive.date_display(:date)
    end
    column :archive_type, sortable: "archive_type.name"
    column :archive_classification, sortable: "archive_classification.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :general_search, as: :string
  filter :title_cont, label: Archive.human_attribute_name(:title)
  filter :archive_classification, input_html: { class: "tom-select-init" }
  filter :archive_type, input_html: { class: "tom-select-init" }
  filter :language, input_html: { class: "tom-select-init" }
  filter :date
  filter :issuing_agency, input_html: { class: "tom-select-init" }
  filter :receiver_agency, input_html: { class: "tom-select-init" }
  filter :people_cited, label: "Pessoas citadas", multiple: true, collection: proc { Person.order(:last_name) },
                        input_html: { class: "tom-select-init" }

  show do
    columns do
      column span: 2 do
        render "admin/shared/images", { record: archive }
      end
      column do
        render "admin/shared/pdf", { record: archive }
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :title
          row :archive_classification
          row :archive_type
          row :city
          row :state
          row :country
          row(:date) { archive.date_display(:date) }
          row :language
          row :document_code
          row :document_number
          row :page_count
          row :donor
        end
      end
      column do
        panel Archive.human_attribute_name(:versions) do
          render partial: "admin/shared/version"
        end
      end
    end

    panel Archive.human_attribute_name(:institutions) do
      columns do
        column do
          attributes_table title: "Emissor" do
            row :from_name
            row :from_role
            row :issuing_agency
          end
        end
        column do
          attributes_table title: "Destinatário" do
            row :to_name
            row :to_role
            row :receiver_agency
          end
        end
      end
    end

    render "admin/shared/people_cited", { record: archive }
    render "admin/shared/extra_info", { record: archive }

    active_admin_comments
  end

  form partial: "form"
end
