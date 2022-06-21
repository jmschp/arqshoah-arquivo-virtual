# frozen_string_literal: true

ActiveAdmin.register NewspaperType do
  menu parent: "Newspapers", label: NewspaperType.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: NewspaperType.human_attribute_name(:name)
end
