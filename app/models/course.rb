class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :university
  has_many :posts
  has_many :enrolls
  has_many :users, :through => :enrolls
  
  def name_with_univ
  	"#{name}, #{university.name}"
  end
end
