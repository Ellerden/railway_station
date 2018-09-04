require_relative 'main_menu'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
# создание и управление маршрутами
class Route
  include InstanceCounter
  include Validation
  attr_reader :starting_station, :terminal_station, :full_path
  @@routes = []

  validate :starting_station, :presence
  validate :terminal_station, :presence
  validate :starting_station, :type, Station
  validate :terminal_station, :type, Station

  # Начальная и конечная станции указываются при создании маршрута,
  # а промежуточные могут добавляться между ними.
  def initialize(starting_station, terminal_station)
    @starting_station = starting_station
    @terminal_station = terminal_station
    @full_path = [@starting_station, @terminal_station]
    @@routes << self
    register_instance
  end

  # добавлять промежуточную станцию в список (на предпоследнее место)
  def add_station(station)
    return if !station.is_a?(Station) || @full_path.include?(station)
    @full_path.insert(-2, station)
  end

  # удаляет промежуточную станцию из списка
  def delete_station(station)
    # проверяем, является ли станция промежуточной и вообще станцией. если да -
    # удаляем
    return if !station.is_a?(Station) || (station == @starting_station ||
      station == @terminal_station)
    @full_path.delete(station)
  end

  # выводит список всех станций по-порядку от начальной до конечной
  def all_stations
    names = []
    @full_path.each { |station| names << station.name }
    names
  end

  # показывает все созданные маршруты
  def self.all
    @@routes.map.with_index { |route, i| "#{i + 1}: #{route.all_stations}" }
  end

  def self.by_index(index)
    @@routes[index - 1]
  end

  class << self
    def empty?
      @@routes.empty?
    end

    def last
      @@routes.last
    end
  end
end
