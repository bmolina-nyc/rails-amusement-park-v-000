class User < ActiveRecord::Base
  # write associations here
  has_secure_password
  has_many :rides
  has_many :attractions, through: :rides



  # note you dont need to write "self" here if its just a method call
  # for an object that has that particular method
  def mood 
    if happiness.present? && nausea.present?
      happiness > nausea ? "happy"  : "sad"
    end
  end

end
