module Api
  module V1
    # Posts controller with endpoints for CRUD on Post model
    class PostsController < ApiController
      before_action :set_post, only: %i[update destroy edit]

      # GET /posts
      def index
        @posts = Post.includes(user: :accounts).includes(:comments).includes(:tags).where(post_id: nil).order('created_at DESC')
        paginate json: @posts, include: %w[comments users]
      end

      # GET /posts/1
      def show
        render json: @post
      end

      # POST /posts
      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created, location: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/1
      def destroy
        @post.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :body, :views, :user_id, :account_id)
      end
    end
  end
end
