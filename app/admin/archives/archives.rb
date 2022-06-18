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

  show do
    columns do
      column span: 2 do
        panel "Imagens do Arquivo" do
          if archive.images.present?
            div class: "admin-show-images" do
              archive.images.each do |image|
                div do
                  link_to rails_blob_path(image, disposition: "inline"), target: :_blank, rel: :noopener do
                    image_tag image.variant(resize_to_fill: [200, 250, { crop: :attention }])
                  end
                end
              end
            end
          else
            div class: "admin-show-image" do
              image_tag "arqshoah-logo.png"
            end
          end
        end
      end
      column do
        panel Archive.human_attribute_name(:pdf) do
          if archive.pdf.present?
            text_node link_to("Abrir", rails_blob_path(archive.pdf, disposition: "inline"), target: :_blank,
                                                                                            rel: :noopener)
            render "active_storage/blobs/blob", blob: archive.pdf, size: [150, 200]
          else
            text_node "sem anexo"
          end
        end
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
        panel "Versões" do
          render partial: "admin/shared/version"
        end
      end
    end

    panel "Informações sobre Instituições" do
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

    panel Archive.human_attribute_name(:people_cited) do
      columns do
        column do
          panel Survivor.model_name.human do
            table_for archive.survivors_citations do
              column :name
            end
          end
        end
        column do
          panel Savior.model_name.human do
            table_for archive.savior_citations do
              column :name
            end
          end
        end
        column do
          panel Commoner.model_name.human do
            table_for archive.commoners_citations do
              column :name
            end
          end
        end
      end
    end

    panel Archive.human_attribute_name(:description) do
      archive.description
    end
    panel Archive.human_attribute_name(:observation) do
      archive.observation
    end
    active_admin_comments
  end

  form partial: "form"
end
