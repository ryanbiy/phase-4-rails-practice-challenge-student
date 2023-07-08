class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :major, :age, :instructor_id

  belongs_to :instructor
end
