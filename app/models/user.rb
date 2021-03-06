class User < ActiveRecord::Base
    has_many :builds
    has_secure_password
    validates_uniqueness_of :email, :username
end