class HomeController < ApplicationController
  def index
    if user_signed_in?
      @monthly_points = current_user.point_logs.where(created_at: Time.current.all_month).sum(:points)
      
      @ranking = current_user.company.users
        .left_joins(:point_logs)
        .where(point_logs: { created_at: Time.current.all_month }).or(current_user.company.users.where.not(id: nil)) # Logic tricky for 0 points with time range.
        # Simplified: Just join point logs in range?
        # Let's do a simpler query:
      
      # Grouping by user and summing points
      @ranking = User.where(company: current_user.company)
                     .joins(:point_logs)
                     .where(point_logs: { created_at: Time.current.all_month })
                     .group(:id)
                     .select("users.*, SUM(point_logs.points) as total_points")
                     .order("total_points DESC")
                     .limit(5)

      @recent_interactions = current_user.company.interactions.includes(:customer, :user).order(created_at: :desc).limit(5)
    end
  end
end
