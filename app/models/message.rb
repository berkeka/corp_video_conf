# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user#, class_name: :User

  validates :content, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
