# frozen_string_literal: true

ActiveAdmin.register IconographyType do
  menu parent: "Iconographies", label: IconographyType.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: IconographyType.human_attribute_name(:name)
end
