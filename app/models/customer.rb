class Customer < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :media_source, optional: true
  has_many :projects
end
