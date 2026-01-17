class UtilitiesController < ApplicationController
  def preview_markdown
    content = params[:content] || ""
    render plain: helpers.markdown(content)
  end
end
