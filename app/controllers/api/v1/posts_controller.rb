module Api
  module V1
    # Posts controller with endpoints for CRUD on Post model
    class PostsController < ApiController
      before_action :doorkeeper_authorize!, except: %i[index show search]
      before_action :set_post, only: %i[update destroy edit]

      # GET /posts
      def index
        @posts = if params[:tag].present?
                   Post.includes(user: :accounts).includes(:comments).includes(:tags).where(post_id: nil).tagged_with(params[:tag]).order('created_at DESC')
                 else
                   Post.includes(user: :accounts).includes(:comments).includes(:tags).where(post_id: nil).order('created_at DESC')
                 end
        paginate json: @posts, include: %w[comments users]
      end

      # GET /posts/1
      def show
        @post = Post.includes(user: :accounts).includes(:comments).includes(:tags).friendly.find(params[:id])
        if @post.post_id.nil?
          @post.views = @post.views + 1
          @post.save
        end
        render json: @post, include: %w[comments users]
      end

      # POST /posts
      def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        @post.account_id = current_account.id
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        if @post.user_id == current_user.id
          if @post.update(post_params)
            render json: @post
          else
            render json: @post.errors, status: :unprocessable_entity
          end
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
        @post = Post.friendly.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:data).require(:attributes).permit(:title, :post_id, :body, tag_list: [])
      end
    end
  end
end
