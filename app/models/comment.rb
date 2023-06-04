# frozen_string_literal: true

class Comment < ApplicationRecord
  paginates_per 4

  belongs_to :account
  belongs_to :practice
end
