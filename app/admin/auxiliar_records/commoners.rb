# frozen_string_literal: true

ActiveAdmin.register Commoner do
  menu parent: "auxiliar_records"
  actions :all, except: [:show]

  permit_params :first_name, :last_name

  index do
    selectable_column
    column :id do |commoner|
      link_to commoner.id, edit_admin_commoner_path(commoner)
    end
    column :first_name
    column :last_name
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  filter :first_name_or_last_name_cont, label: Commoner.human_attribute_name(:name)

  form do |f|
    f.inputs "Nome" do
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end
end
