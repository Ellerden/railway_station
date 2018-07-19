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
  def show_trains_by_type(type = :all)
    selected_trains = @trains.select { |train| train.type == type || type == :all }
    if !selected_trains.empty?
      selected_trains.each do |train|
        puts "Поезд: #{train.num}, тип: #{train.type}, кол-во вагонов: #{train.waggonage}"
      end
    else
      puts "На станции #{self.name} нет поездов типа #{type}"
    end
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
