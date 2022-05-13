# frozen_string_literal: true

ActiveAdmin.register Archive do
  index do
    selectable_column
    column :registration, sortable: :id do |archive|
      link_to archive.registration, admin_archive_path(archive)
    end
    column :title
    column :date do |archive|
      archive.date_display(:date)
    end
    column :archive_type, sortable: "archive_type.name"
    column :archive_classification, sortable: "archive_classification.name"
    column :created_at
    column :updated_at
    actions dropdown: true
  end
end
