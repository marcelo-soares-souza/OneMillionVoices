# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :practice
  belongs_to :account

  validates :account_id, uniqueness: { scope: :practice_id }
end
