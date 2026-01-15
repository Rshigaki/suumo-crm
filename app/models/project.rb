class Project < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :company

  enum :status, { pending: 0, negotiating: 1, contracted: 2, started: 3, delivered: 4 }
end
