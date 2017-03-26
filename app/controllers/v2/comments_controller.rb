class V2::CommentsController < V2::BaseController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /v2/comments
  def index
    @comments = Comment.all
    if stale?(@comments)
      render json: @comments
    end
  end

  # GET /v2/comments/1
  def show
    if stale?(@comment)
      render json: @comment
    end
  end

  # POST /v2/comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment,
             status: :created,
             location: v2_comment_url(@comment)
    else
      respond_with_validation_error @comment
    end
  end

  # PATCH/PUT /v2/comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      respond_with_validation_error @comment
    end
  end

  # DELETE /v2/comments/1
  def destroy
    @comment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:card_id, :creator_id, :body)
  end
end
