#encoding: UTF-8
require_relative "station"

class Route
  attr_reader :starting_station, :terminal_station, :full_path
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
  def initialize(starting_station, terminal_station)
    if !starting_station.nil? && !terminal_station.nil?
      @full_path = [starting_station, terminal_station]
      @starting_station = starting_station
      @terminal_station = terminal_station
    else
      abort "Невозможно построить маршрут — нужны начальная и конечная станции"
    end
  end
# добавлять промежуточную станцию в список (на предпоследнее место)
  def add_station(station)
    unless @full_path.include? station
      @full_path.insert(-2, station)
    end
  end
# удаляет промежуточную станцию из списка
  def delete_station(station)
    # проверяем, является ли станция промежуточной. если да - удаляем
    unless station == @starting_station || station == @terminal_station
      @full_path.delete(station)
    end
  end
# выводит список всех станций по-порядку от начальной до конечной
  def show
    @full_path.each { |station| puts "#{station.name} "}
  end
end
