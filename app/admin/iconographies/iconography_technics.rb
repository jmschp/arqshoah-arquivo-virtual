# frozen_string_literal: true

ActiveAdmin.register IconographyTechnic do
  menu parent: "Iconographies", label: IconographyTechnic.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: IconographyTechnic.human_attribute_name(:name)
end
