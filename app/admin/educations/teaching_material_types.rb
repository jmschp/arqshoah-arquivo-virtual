# frozen_string_literal: true

ActiveAdmin.register TeachingMaterialType do
  menu parent: "Educations", label: TeachingMaterialType.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: TeachingMaterialType.human_attribute_name(:name)
end
