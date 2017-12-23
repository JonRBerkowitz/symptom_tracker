class Symptom < ActiveRecord::Base
  has_many :user_symptoms
  has_many :users, :through => :user_symptoms
end
