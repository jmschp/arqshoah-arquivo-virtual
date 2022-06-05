# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  actions :all, except: [:new]

  permit_params :email, :name, :password, :password_confirmation

  action_item :password_change, only: :show, if: proc { current_admin_user.id == params[:id].to_i } do
    link_to I18n.t(:btn_edit_password), password_change_admin_admin_user_path
  end

  member_action :password_change, method: %i[get patch] do
    redirect_to admin_root_path, alert: I18n.t(:password_change_alert) unless current_admin_user.id == params[:id].to_i

    if request.patch?
      if resource.update(password: params[:password], password_confirmation: params[:password_confirmation])
        redirect_to admin_admin_user_path(resource)
      else
        render :password_change
      end
    end
  end

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
    end
    f.actions
  end
end
