# frozen_string_literal: true

ActiveAdmin.register EducationCategory do
  menu parent: "Educations", label: EducationCategory.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: EducationCategory.human_attribute_name(:name)
end
