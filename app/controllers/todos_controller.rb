class TodosController < ApplicationController
  def new
    @todo = Todo.new
  end

  def index 
    #params[:tag] ? @todo = Todo.tagged_with(params[:tag]) : @todo = Todo.all
    @todo = Todo.all
    @tag = Tag.all
  end
  
  def show
    @todo = Todo.find(params[:id])
  end

  def create
    # .create is equivalent to .new followed by .save
    # However, .create does not allow us to catch any validation errors
    @todo = Todo.new(todo_params) 

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
    @todo = Todo.find(params[:id])
  end

  def update
     @todo = Todo.find(params[:id])

     if @todo.update(todo_params)
      redirect_to @todo
     else
      render 'edit'
     end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    redirect_to todos_path
  end

  private
    def todo_params
      # strong parameter: forces the item to require fields according to the symbol and allows only the chosen parameters to be passed through
      params.require(:todo).permit(:item, :details, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end
end