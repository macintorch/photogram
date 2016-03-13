class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
	before_action :owned_post, only: [:edit, :update, :destroy]

	def index
		@posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = "Your post has been created!"
			redirect_to posts_path
		else
			flash.now[:alert] = "Your new post couldn't be created! Please check the form"
			render :new
		end
	end

	def show
		
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post updated."
			redirect_to post_path
		else
			flash.now[:alert] = "Update failed. Please check the form."
			render :edit
		end 
	end

	def destroy
		if @post.destroy
			flash[:success] = "Your post was deleted."
			redirect_to posts_path
		else
			flash.now[:alert] = "Delete failed."
			render :edit
		end
	end

	def like
		if @post.liked_by current_user #liked_bt is from acts_as_votable gem
			respond_to do |format|
				format.html { redirect_to :back}
				format.js
			end
		end
	end

	def browse  
	  @posts = Post.all.order('created_at DESC').page params[:page]
	end  

	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post
		unless current_user == @post.user
			flash[:alert] = "That post doesn't belong to you!"
			redirect_to root_path
		end
	end
end
