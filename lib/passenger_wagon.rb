require_relative 'wagon'
# Создание и управление пассажирскими вагонами
class PassengerWagon < Wagon
  # возвращает количество занятых мест в вагоне - переменная taken_places
  # возвращает количество мест в вагоне - переменная places
  attr_reader :places, :taken_places
  public_class_method :new

  def initialize(manufacturer, places)
    @type = :pass
    @places = places
    @taken_places = 0
    super
    @@all_wagons << self
  end

  # "занимает места" в вагоне (по одному за раз)
  def take_place
    @taken_places += 1 unless @taken_places == @places
  end
end
