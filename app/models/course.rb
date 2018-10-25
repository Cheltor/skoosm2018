class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :university
  has_many :posts
  
  def name_with_univ
  	"#{name}, #{university.name}"
  end
end
