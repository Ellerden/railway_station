require_relative 'train'
require_relative 'main_menu'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
# создание и управление ж/д станцией
class Station
  include InstanceCounter
  extend Accessors
  include Validation
  attr_accessor_with_history :name
  @@stations = {}

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    register_instance
  end

  # список всех поездов на станции, находящиеся в текущий момент
  # список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_by_type(type = :all)
    @trains.select { |train| train.type == type || type == :all } \
           .map { |train| "Поезд: #{train.num}, тип: #{train.type}" }
  end

  # принимает поезда (по одному за раз)
  def arrival(train)
    trains << train unless trains.include? train
  end

  # отправляет поезда (по одному за раз. поезд удаляется из списка поездов)
  def departure(train)
    trains.delete(train)
  end

  # показывает все созданные станции
  def self.all
    @@stations.keys
  end

  def self.find_station_by_name(name)
    @@stations[name]
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  # переменная trains - используется только в методах класса,
  # юзер может посмотреть поезда на станции через show_trains_by_type
  # к массиву trains напрямую доступ юзеру не нужен

  private

  attr_reader :trains
end
