class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :going

  def going
    object.instance_variable_get(:@going)
  end
end