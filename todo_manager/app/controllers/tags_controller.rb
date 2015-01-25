class TagsController < ApplicationController
	before_action :all_tags, only: [:index, :create, :update, :destroy]
	respond_to :html, :js

	def new
		@tag = Tag.new
	end

	def create
		flash[:notice] = "New tag successfully created!"
	  @tag = Tag.new(tag_params)
	 
	  if @tag.save
	    redirect_to tags_path
	  else
	    render 'new'
	   end
	end

	def edit
	  @tag = Tag.find(params[:id])
	end

	def update
	  @tag = Tag.find(params[:id])
	 
	  if @tag.update(tag_params)
	    redirect_to tags_path
	  else
	    render 'edit'
	  end
	end


	def destroy
	  @tag = Tag.find(params[:id])
	  @tag.destroy
	 
	  redirect_to tags_path
	end

	private
		def all_tags
      @tags = Tag.all
  	end

	  def tag_params
	    params.require(:tag).permit(:name, :color)
	  end
end
