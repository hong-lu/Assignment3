class TasksController < ApplicationController
	def index
	  @tasks = Task.all
	end

	def pending
		@tasks = []
		Task.order(:due_date).each do |t|
			if t.due_date >= Time.now.to_datetime && (!(t.is_complete))
				@tasks.push(t)
			end
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

	def filter
		@tasks  = Task.tagged_with(params[:format]);
	end

	def mark
		@task = Task.find(params[:task_id])
		if (@task.is_complete)
			@task.update_attribute(:is_complete, false)
		else
			@task.update_attribute(:is_complete, true)
		end
		redirect_to tasks_path
	end

	private
	  def task_params
	    params.require(:task).permit(:title, :text, :due_date, :tag_list)
	  end

end
