# frozen_string_literal: true

ActiveAdmin.register ArchiveType do
  menu parent: "Archives", label: ArchiveType.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: ArchiveType.human_attribute_name(:name)
end
