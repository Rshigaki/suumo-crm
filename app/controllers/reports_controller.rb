class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @media_reports = current_user.company.media_sources.map do |source|
        {
            name: source.name,
            leads: source.customers.count,
            contracts: source.customers.joins(:projects).where(projects: { status: [:contracted, :started, :delivered] }).count,
            contract_rate: (source.customers.joins(:projects).where(projects: { status: [:contracted, :started, :delivered] }).count.to_f / source.customers.count.to_f * 100).nan? ? 0 : (source.customers.joins(:projects).where(projects: { status: [:contracted, :started, :delivered] }).count.to_f / source.customers.count.to_f * 100).round(1)
        }
    end
  end
end
