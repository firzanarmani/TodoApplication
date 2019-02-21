class TodosController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  skip_before_action :verify_authenticity_token, only: :update
  before_action :authenticate_user!

  def new
    @todo = Todo.new
    @tag = Tag.new
  end

  def index 
    #params[:tag] ? @todo = Todo.tagged_with(params[:tag]) : @todo = Todo.all
    @todo = current_user.todos
    @tag = current_user.tags
  end
  
  def show
    @todo = current_user.todos.find(params[:id])
  end

  def create
    # .create is equivalent to .new followed by .save
    # However, .create does not allow us to catch any validation errors
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    

    # .save returns a boolean if saved. Item is saved only if it passes validation
    if @todo.save
      redirect_to @todo
    else
      # If validation failed, run todos#new; passing back the @todo object back into the new template
      render 'new'
    # .create! is a another possible solution. It raises an exception when validation fails
    end

  end

  def edit
    @todo = current_user.todos.find(params[:id])
  end

  def update
     @todo = current_user.todos.find(params[:id])

     if @todo.update(todo_params)
      redirect_to @todo
     else
      render 'edit'
     end
  end

  def destroy
    @todo = current_user.todos.find(params[:id])
    @todo.destroy

    redirect_to todos_path
  end

  def done
    @todo = Todo.find(params[:id])
    if @todo.done == false
      @todo.update_attribute(:done, true)
      redirect_to @todo
    else
      @todo.update_attribute(:done, false)
      redirect_to @todo
    end
  end

  private
    def todo_params
      # strong parameter: forces the item to require fields according to the symbol and allows only the chosen parameters to be passed through
      params.require(:todo).permit(:item, :details, :ddeadline, :tdeadline, :tag, { tag_ids: [] }, :tag_ids)
    end

    # def tag_params
    #   params.require(:tag).permit(:name, :tags)
    # end
    
end