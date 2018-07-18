#encoding: UTF-8
require_relative "train"

class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end
# список всех поездов на станции, находящиеся в текущий момент
# список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_count(type = "все")
    result = ["На станции #{self.name} // тип: #{type}"]
    @trains.select do |train|
      if train.type == type.capitalize
        result << "Номер поезда: #{train.num}, тип: #{train.type}, "\
        "кол-во вагонов: #{train.waggonage}"
      else
        abort "На станции #{self.name} поездов типа #{type} нет."
      end
    end
     result
  end
# принимает поезда (по одному за раз)
  def arrival(train)
    unless trains.include? train
      trains << train
    end
  end
# отправляет поезда (по одному за раз. поезд удаляется из списка поездов)
  def departure(train)
    trains.delete(train)
  end
end
