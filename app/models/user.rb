# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :conversations, dependent: :destroy

  enum role: { admin: 0, employee: 1, customer: 2 }

  after_initialize do
    self.role ||= :customer if new_record?
  end
end
