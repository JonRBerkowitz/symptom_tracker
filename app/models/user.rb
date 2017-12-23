class User < ActiveRecord::Base
  has_secure_password

  has_many :posts

  has_many :user_symptoms
  has_many :symptoms, :through => :user_symptoms

  has_many :user_medications
  has_many :medications, :through => :user_medications
end
