class Api::V1::ContentSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :updated_at

  def initialize(object)
    super(object, {})
  end
end
