class User < ApplicationRecord
    has_many :contents

    validates :email, presence: true, uniqueness: true
end
