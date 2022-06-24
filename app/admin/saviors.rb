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

  filter :general_search, as: :string
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
        render "admin/shared/images", { record: savior }
      end
      column do
        render "admin/shared/pdf", { record: savior }
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
        panel Savior.human_attribute_name(:versions) do
          render partial: "admin/shared/version"
        end
      end
    end

    render "admin/shared/professional_activities", { record: savior }
    render "admin/shared/extra_info", { record: savior }

    active_admin_comments
  end

  form partial: "form"
end
