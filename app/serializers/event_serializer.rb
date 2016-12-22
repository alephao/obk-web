class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date
end