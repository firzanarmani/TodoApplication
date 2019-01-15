class TagsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @tag = current_user.tags.find(params[:id])
  end
end