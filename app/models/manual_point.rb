# frozen_string_literal: true

class ManualPoint < ApplicationRecord
  belongs_to :member
  enum reason: { miscellaneous: 0, volunteer: 10, transfer_old: 20 }
end
