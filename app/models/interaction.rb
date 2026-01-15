class Interaction < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :user
  belongs_to :company

  enum :status, { recording: 0, processing: 1, completed: 2 }
end
