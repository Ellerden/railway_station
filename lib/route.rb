# encoding: UTF-8

require_relative 'station'
require_relative 'main_menu'
require_relative 'instance_counter'
  # создание и управление маршрутами
class Route
  include InstanceCounter
  attr_reader :starting_station, :terminal_station, :full_path
  @@routes = []
  # Начальная и конечная станции указываются при создании маршрута,
  # а промежуточные могут добавляться между ними.
  def initialize(starting_station, terminal_station)
    @starting_station = starting_station
    @terminal_station = terminal_station
    validate!
    @full_path = [starting_station, terminal_station]

    @@routes << self
    register_instance
  end

# добавлять промежуточную станцию в список (на предпоследнее место)
  def add_station(station)
    @full_path.insert(-2, station) unless @full_path.include? station
  end

# удаляет промежуточную станцию из списка
  def delete_station(station)
# проверяем, является ли станция промежуточной. если да - удаляем
    unless station == @starting_station || station == @terminal_station
      @full_path.delete(station)
    end
  end

# выводит список всех станций по-порядку от начальной до конечной
  def all_stations
    names = []
    @full_path.each { |station| names << station.name }
    names
  end

# показывает все созданные маршруты
  def self.all
    all_routes = @@routes.map \
    .with_index { |route, i| "#{i + 1}: #{route.all_stations}" }
  end

  def self.by_index(index)
    @@routes[index - 1]
  end

  protected

  def validate!
    unless valid?
      raise 'Неверно заданы начальная или конечная станции. Проверьте список'\
        ' существующих станций'
    end
  end

  def valid?
    unless Station.find_station_by_name(@starting_station.name).nil? ||
      Station.find_station_by_name(@terminal_station.name).nil?
      return true
    end
      false
  end

  # показывает последний созданный маршрут. нужно для добавления/удаления станции
  # из маршрута через меню (class RouteMenu). юзеру не нужен этот метод
  def self.last
    @@routes.last
  end

  # нужно чтобы знать RouteMenu есть ли какие маршруты показывать или нет
  # конечному пользователю не нужно
  def self.empty?
    @@routes.empty?
  end
end
