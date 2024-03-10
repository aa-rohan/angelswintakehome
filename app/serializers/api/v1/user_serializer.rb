class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :country, :created_at, :updated_at

  def initialize(object)
    super(object, {})
  end

  def name
    "#{object.first_name}  #{object.last_name}"
  end
end
