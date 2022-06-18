# frozen_string_literal: true

ActiveAdmin.register Language do
  menu parent: "auxiliar_records"
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: Language.human_attribute_name(:name)
end
