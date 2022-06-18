# frozen_string_literal: true

ActiveAdmin.register Religion do
  menu parent: "auxiliar_records"
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: Religion.human_attribute_name(:name)
end
