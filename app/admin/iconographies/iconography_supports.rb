# frozen_string_literal: true

ActiveAdmin.register IconographySupport do
  menu parent: "Iconographies", label: IconographySupport.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: IconographySupport.human_attribute_name(:name)
end
