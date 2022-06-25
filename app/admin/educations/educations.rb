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

  controller do
    def show
      @education = Education.includes(versions: :item).find(params[:id])
      @versions = @education.versions
      @education = @education.versions[params[:version].to_i] if params[:version]
    end
  end

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

  show do
    columns do
      column span: 2 do
        render "admin/shared/images", { record: education }
      end
      column do
        render "admin/shared/pdf", { record: education }
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :title
          row :education_category
          row :venue
          row :start_date
          row :end_date
          row :target_public
          row :online
        end
      end
      column do
        panel Education.human_attribute_name(:versions) do
          render partial: "admin/shared/version"
        end
      end
    end

    columns do
      column do
        panel Education.human_attribute_name(:promoter_institutions) do
          table_for education.promoter_institutions do
            column :name
          end
        end
      end
      column do
        panel Education.human_attribute_name(:organizers) do
          table_for education.organizers do
            column :name
          end
        end
      end
    end

    panel Education.human_attribute_name(:education_supporters) do
      columns do
        column do
          panel Education.human_attribute_name(:organization_supporters) do
            table_for education.organization_supporters do
              column :name
            end
          end
        end
        column do
          panel Education.human_attribute_name(:person_supporters) do
            table_for education.person_supporters do
              column :name
            end
          end
        end
      end
    end

    panel TeachingMaterial.model_name.human do
      columns do
        column do
          attributes_table_for education.teaching_material do
            row :title
            row :publication_year
            row :pages
            row(:recording_link) do
              link_to_if(
                education.teaching_material.recording_link.present?, nil,
                education.teaching_material.recording_link,
                { target: :_blank, rel: :noopener }
              )
            end
            row :recording_hours
            row :teaching_material_type
            row :publishing_company
          end
        end
        column do
          panel TeachingMaterial.human_attribute_name(:authors) do
            table_for education.teaching_material&.authors do
              column :name
            end
          end
        end
        column do
          render "admin/shared/pdf", { record: education.teaching_material }
        end
      end
    end

    render "admin/shared/extra_info", { record: education }

    active_admin_comments
  end
end
