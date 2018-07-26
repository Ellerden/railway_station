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
    unless station_valid?(station) && @full_path.include?(station)
      @full_path.insert(-2, station)
    end
  end

# удаляет промежуточную станцию из списка
  def delete_station(station)
    # проверяем, является ли станция промежуточной и вообще станцией. если да - удаляем
    unless station_valid?(station) && (station == @starting_station ||
      station == @terminal_station)
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

  def valid?
    begin
      validate!
      result = true
    rescue RuntimeError => e
      puts 'Что-то пошло не так. Ошибка: #{e.inspect} '
      result = false
    end
  end

  protected

  def validate!
    unless station_valid?(@starting_station)
      raise 'Неверно задана начальная станция. Проверьте список станций'
    end
    unless station_valid?(@terminal_station)
      raise 'Неверно задана конечная станция. Проверьте список станций'
    end
  end

  def station_valid?(station)
    return false if Station.find_station_by_name(station.name).nil?
    true
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
