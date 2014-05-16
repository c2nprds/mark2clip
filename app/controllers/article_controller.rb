class ArticleController < ApplicationController
  # TODO:: verify_authenticity_token
  skip_before_filter :verify_authenticity_token, only: [:gfm]

  def gfm
    if params[:markdown].present?
      render html: GitHub::Markdown.render_gfm(params[:markdown]).html_safe
    else
      render nothing: true
    end
  end
end
