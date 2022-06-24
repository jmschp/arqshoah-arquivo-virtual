# frozen_string_literal: true

ActiveAdmin.register Survivor do
  permit_params(
    :academic_formation, :birth_date_day, :birth_date_month, :birth_date_year, :birth_place,
    :death_date_day, :death_date_month, :death_date_year, :death_place, :first_name,
    :last_name, :name_variation, :gender, :pdf, :other_family_members, :description, :observation,
    :professional_activities, :religion_id, :mother_id, :father_id, :spouse_id,
    { images: [], interviews_given_attributes: %i[id date location interviewer_id _destroy] }
  )

  controller do
    def show
      @survivor = Survivor.includes(versions: :item).find(params[:id])
      @versions = @survivor.versions
      @survivor = @survivor.versions[params[:version].to_i].reify if params[:version]
    end
  end

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

  filter :general_search, as: :string
  filter :name_cont, label: Survivor.human_attribute_name(:name)
  filter :birth_place_country_eq, collection: proc { Survivor.all.pluck(:birth_place_country) },
                                  label: Survivor.human_attribute_name(:birth_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :death_place_country_eq, collection: proc { Survivor.all.pluck(:death_place_country) },
                                  label: Survivor.human_attribute_name(:death_place_country),
                                  input_html: { class: "tom-select-init" }
  filter :birth_date
  filter :death_date
  filter :religion, input_html: { class: "tom-select-init" }

  show do
    columns do
      column span: 2 do
        render "admin/shared/images", { record: survivor }
      end
      column do
        render "admin/shared/pdf", { record: survivor }
      end
      column span: 2 do
        attributes_table do
          row :registration
          row :name
          row :name_variation
          row(:gender) { Person.human_attribute_name("gender.#{survivor.gender}") }
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
        panel Survivor.human_attribute_name(:versions) do
          render partial: "admin/shared/version"
        end
      end
    end

    panel Survivor.human_attribute_name(:family) do
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
      panel Survivor.human_attribute_name(:other_family_members) do
        survivor.other_family_members
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

    render "admin/shared/professional_activities", { record: survivor }
    render "admin/shared/extra_info", { record: survivor }

    active_admin_comments
  end

  form partial: "form"
end
