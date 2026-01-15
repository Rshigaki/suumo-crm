class Company < ApplicationRecord
  has_many :users
  has_many :customers
  has_many :projects
  has_many :interactions
  has_many :point_logs
  has_many :media_sources
end
