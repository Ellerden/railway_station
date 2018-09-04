require_relative 'wagon'
require_relative 'validation'
# Создание и управление пассажирскими вагонами
class PassengerWagon < Wagon
  include Validation
  # возвращает количество занятых мест в вагоне - переменная taken_places
  # возвращает количество мест в вагоне - переменная places
  attr_reader :places, :taken_places
  public_class_method :new

  validate :company_name, :presence

  def initialize(manufacturer, places)
    @type = self.class
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
