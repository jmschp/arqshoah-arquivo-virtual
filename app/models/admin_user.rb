# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # rubocop:disable Layout/LineLength
  devise :database_authenticatable, :confirmable, :invitable, :lockable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  validates :email, confirmation: true, length: { maximum: 255 }
  validates :email_confirmation, presence: true, if: :email_changed?
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: :encrypted_password_changed?, on: :update
  # rubocop:enable Layout/LineLength
end
