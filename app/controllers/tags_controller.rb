class TagsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @tag = current_user.tags.find(params[:id])
  end

  def edit
    @tag = current_user.tags.all
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user
    
    if @tag.save
      redirect_back(fallback_location: todos_path) 
    end
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end