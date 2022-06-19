# frozen_string_literal: true

ActiveAdmin.register Savior do
  permit_params(
    :academic_formation, :birth_date_day, :birth_date_month, :birth_date_year, :birth_place, :death_date_day,
    :death_date_month, :death_date_year, :death_place, :first_name, :last_name, :gender, :pdf, :description,
    :observation, :professional_activities, :religion_id, { images: [] }
  )

  controller do
    def show
      @savior = Savior.includes(versions: :item).find(params[:id])
      @versions = @savior.versions
      @savior = @savior.versions[params[:version].to_i].reify if params[:version]
    end
  end

  index do
    selectable_column
    column :registration, sortable: :id do |savior|
      link_to savior.registration, admin_savior_path(savior)
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
  filter :birth_place_country_eq, collection: proc { Savior.all.pluck(:birth_place_country) },
                                  label: Savior.human_attribute_name(:birth_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :death_place_country_eq, collection: proc { Savior.all.pluck(:death_place_country) },
                                  label: Savior.human_attribute_name(:death_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :birth_date
  filter :death_date
  filter :religion, input_html: { class: "tom-select-init" }

  show do
    columns do
      column span: 2 do
        panel Savior.human_attribute_name(:images) do
          if savior.images.present?
            div class: "admin-show-images" do
              savior.images.each do |image|
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
        panel Savior.human_attribute_name(:pdf) do
          if savior.pdf.present?
            text_node link_to("Abrir", rails_blob_path(savior.pdf, disposition: "inline"), target: :_blank,
                                                                                           rel: :noopener)
            render "active_storage/blobs/blob", blob: savior.pdf, size: [150, 200]
          else
            text_node "sem anexo"
          end
        end
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :name
          row(:gender) { Person.human_attribute_name("gender.#{savior.gender}") }
          row(:birth_date) { savior.date_display(:birth_date) }
          row :birth_place_city
          row :birth_place_state
          row :birth_place_country
          row(:death_date) { savior.date_display(:death_date) }
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

    panel Savior.human_attribute_name(:professional_activities) do
      para do
        sanitize(
          "<strong>#{Savior.human_attribute_name(:academic_formation)}:</strong> #{savior.academic_formation}",
          { tags: %w[strong] }
        )
      end
      div do
        savior.professional_activities
      end
    end

    panel Savior.human_attribute_name(:description) do
      savior.description
    end
    panel Savior.human_attribute_name(:observation) do
      savior.observation
    end
    active_admin_comments
  end

  form partial: "form"
end
