class Api::V1::ContentsController < ApplicationController
  before_action :authenticate_request!, except: %i[index]
  before_action :set_content, except: %i[index create]
  before_action :authorize_user!, only: %i[update destroy]

  def index
    render json: Content.all.map(&method(:serialized_content))
  end

  def create
    @content = current_user.contents.build(content_params)
    if @content.save
      render json: serialized_content(@content), status: :created
    else
      render json: { error: 'Could not create content' }, status: :unprocessable_entity
    end
  end

  def update
    if @content.update(content_params)
      render json: serialized_content(@content)
    else
      render json: { error: 'Could not update content' }, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy
    render json: { message: 'Deleted' }
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.permit(:title, :body)
  end

  def serialized_content(content)
    {
      id: content.id,
      type: 'contents',
      attributes: Api::V1::ContentSerializer.new(content)
    }
  end

  def authorize_user!
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @content.user_id == current_user.id
  end
end
