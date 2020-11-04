# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_enumeration_for :user_type, create_helpers: true, create_scopes: true

  validates :user_type, :email, presence: true
  validates :email, uniqueness: true
end
