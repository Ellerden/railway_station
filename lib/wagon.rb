require_relative 'train'
require_relative 'main_menu'
require_relative 'manufacturer'
require_relative 'validation'
# Создание и управление вагонами всех типов
class Wagon
  include Manufacturer
  include Validation
  attr_reader :type, :company_name
  # можно создать только объект субкласса PassengerWagon или CargoWagon
  private_class_method :new
  @@all_wagons = []

  validate :type, :between_two_types, 'PassengerWagon || CargoWagon'

  def initialize(manufacturer, *_args)
    self.company_name = manufacturer
  end

  def self.last
    @@all_wagons.last
  end
end
