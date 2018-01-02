class StaticController < ApplicationController
  def show
    render params[:path]
  end
end
