# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # rubocop:disable Metrics/LineLength
  devise :database_authenticatable, :confirmable, :invitable, :lockable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  validates :email, confirmation: true, length: { maximum: 255 }
  validates :email_confirmation, presence: true, if: :email_changed?
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, confirmation: true
  # rubocop:enable Metrics/LineLength
end
