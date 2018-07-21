# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'
require_relative 'instance_counter'
include InstanceCounter

class Station
  attr_reader :name, :trains
  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    register_instance
  end
# список всех поездов на станции, находящиеся в текущий момент
# список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def show_trains_by_type(type = :all)
    selected_trains = @trains.select { |train| train.type == type || type == :all }
    if selected_trains.empty?
      puts "На станции #{self.name} нет поездов типа #{type}"
      return
    end
    selected_trains.each do |train|
      puts "Поезд: #{train.num}, тип: #{train.type}"
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
  # показывает все созданные станции
  def self.all
    @@stations.keys unless @@stations.nil?
  end

  def self.find_station_by_name(name)
    @@stations[name]
  end
# переменная trains - используется только в методах класса,
# юзер может посмотреть поезда на станции через show_trains_by_type
# к массиву trains напрямую доступ юзеру не нужен
  private
  attr_reader :trains
end
