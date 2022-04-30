# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable
end
