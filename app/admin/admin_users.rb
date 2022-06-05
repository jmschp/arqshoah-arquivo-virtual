# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  actions :all, except: [:new]

  permit_params :email, :name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions dropdown: true
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :email
      f.input :email_confirmation
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
