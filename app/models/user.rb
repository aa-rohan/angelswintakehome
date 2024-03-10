class User < ApplicationRecord
  has_secure_password
  has_many :contents

  validates :email, presence: true, uniqueness: true
end
