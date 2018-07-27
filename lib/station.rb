# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'
require_relative 'instance_counter'
# создание и управление ж/д станцией
class Station
  include InstanceCounter
  attr_reader :name
  @@stations = {}

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
    register_instance
  end

  # список всех поездов на станции, находящиеся в текущий момент
  # список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_by_type(type = :all)
    sel_trains = @trains.select { |train| train.type == type || type == :all } \
      .map { |train| "Поезд: #{train.num}, тип: #{train.type}" }
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
    @@stations.keys
  end

  def self.find_station_by_name(name)
    @@stations[name]
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def valid?
    begin
      validate!
      true
    rescue RuntimeError => e
      puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
      false
    end
  end

  protected

  def validate!
    raise 'Неверное имя станции – короче 1 символа' if @name.size < 2
  end

  # переменная trains - используется только в методах класса,
  # юзер может посмотреть поезда на станции через show_trains_by_type
  # к массиву trains напрямую доступ юзеру не нужен

  private

  attr_reader :trains
end
