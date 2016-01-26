class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :date_created, :date_modified, :created_by
  has_many :items

  def date_created
     date = object.created_at
     date.strftime("%F %T")
   end

   def date_modified
     date = object.updated_at
     date.strftime("%F %T")
   end
end
