# frozen_string_literal: true

ActiveAdmin.register ArchiveClassification do
  menu parent: "Archives", label: ArchiveClassification.model_name.human(count: 2)
  actions :all, except: [:show]

  permit_params :name

  filter :name_cont, label: ArchiveClassification.human_attribute_name(:name)
end
