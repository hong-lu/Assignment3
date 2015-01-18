class TasksController < ApplicationController
	def index
	  if params[:tag]
	    @tasks = Task.tagged_with(params[:tag])
	    @tag_name = params[:tag]
	  else
	    @tasks = Task.all
	  end
	end

  def show
    @task = Task.find(params[:id])
  end

  def new
  	@task = Task.new
  end

	def edit
	  @task = Task.find(params[:id])
	end

	def create
		flash[:notice] = "New Task successfully created!"
	  @task = Task.new(task_params)
	 
	  if @task.save
	    redirect_to @task
	  else
	    render 'new'
	   end
	end

	def update
	  @task = Task.find(params[:id])
	 
	  if @task.update(task_params)
	    redirect_to @task
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @task = Task.find(params[:id])
	  @task.destroy
	 
	  redirect_to tasks_path
	end

	private
	  def task_params
	    params.require(:task).permit(:title, :text, :due_date, :tag_list)
	  end

end
