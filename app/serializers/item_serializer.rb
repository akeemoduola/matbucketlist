class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_created, :date_modified, :done

  def date_created
     date = object.created_at
     date.strftime("%F %T")
   end

   def date_modified
     date = object.updated_at
     date.strftime("%F %T")
   end
end
