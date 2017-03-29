class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :going

  def going
    if object.instance_variables.include?(:@going)
      object.instance_variable_get(:@going)
    else
      false
    end
  end
end