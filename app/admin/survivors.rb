# frozen_string_literal: true

ActiveAdmin.register Survivor do
  permit_params(
    :academic_formation, :birth_date_day, :birth_date_month, :birth_date_year, :birth_place,
    :death_date_day, :death_date_month, :death_date_year, :death_place, :first_name,
    :last_name, :name_variation, :gender, :pdf, :family_members, :description, :observation,
    :professional_activities, :religion_id, :mother_id, :father_id, :spouse_id,
    { images: [], interviews_attributes: %i[id date location interviewer_id _destroy] }
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

  # rubocop:disable Metrics/LineLength
  filter :general_search, as: :string, label: "Busca geral"
  filter :name_cont, label: Survivor.human_attribute_name(:name)
  filter :birth_place_country_eq, collection: Survivor.all.pluck(:birth_place_country), label: Survivor.human_attribute_name(:birth_place_country), input_html: { class: "tom-select-init" }
  filter :death_place_country_eq, collection: Survivor.all.pluck(:death_place_country), label: Survivor.human_attribute_name(:death_place_country), input_html: { class: "tom-select-init" }
  filter :birth_date
  filter :death_date
  filter :religion, input_html: { class: "tom-select-init" }
  # rubocop:enable Metrics/LineLength

  show do
    columns do
      column span: 2 do
        panel Survivor.human_attribute_name(:images) do
          if survivor.images.present?
            div class: "admin-show-images" do
              survivor.images.each do |image|
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
        panel Survivor.human_attribute_name(:pdf) do
          if survivor.pdf.present?
            text_node link_to("Abrir", rails_blob_path(survivor.pdf, disposition: "inline"), target: :_blank,
                                                                                             rel: :noopener)
            render "active_storage/blobs/blob", blob: survivor.pdf, size: [150, 200]
          else
            text_node "sem anexo"
          end
        end
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :name
          row :name_variation
          row :gender
          row(:birth_date) { survivor.date_display(:birth_date) }
          row :birth_place_city
          row :birth_place_state
          row :birth_place_country
          row(:death_date) { survivor.date_display(:death_date) }
          row :death_place_city
          row :death_place_state
          row :death_place_country
          row :religion
        end
      end
      column do
        panel "Versões" do
          render partial: "admin/shared/version"
        end
      end
    end

    panel "Informações familiares" do
      columns do
        column do
          attributes_table_for survivor do
            row :mother
            row :father
            row :spouse
          end
        end
        column do
          attributes_table_for survivor do
            Survivor.siblings(survivor.id, survivor.mother_id, survivor.father_id).find_each do |sibling|
              row(:sibling) { sibling.name }
            end
          end
        end
      end
      panel Survivor.human_attribute_name(:family_members) do
        survivor.family_members
      end
    end

    panel Survivor.human_attribute_name(:professional_activities) do
      para do
        sanitize(
          "<strong>#{Survivor.human_attribute_name(:academic_formation)}:</strong> #{survivor.academic_formation}",
          { tags: %w[strong] }
        )
      end
      div do
        survivor.professional_activities
      end
    end

    panel Interview.model_name.human(count: 2) do
      table_for survivor.interviews_given do
        column :city
        column :state
        column :country
        column :date
        column :interviewer
      end
    end

    panel Survivor.human_attribute_name(:description) do
      survivor.description
    end
    panel Survivor.human_attribute_name(:observation) do
      survivor.observation
    end
    active_admin_comments
  end
end
