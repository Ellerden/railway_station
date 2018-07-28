require_relative 'train'
require_relative 'main_menu'
require_relative 'manufacturer'
# Создание и управление вагонами всех типов
class Wagon
  include Manufacturer
  attr_reader :type, :company_name
  # можно создать только объект субкласса PassengerWagon или CargoWagon
  private_class_method :new
  @@all_wagons = []

  def initialize(manufacturer, *_args)
    self.company_name = manufacturer
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e
    puts "Что-то пошло не так. Ошибка: #{e.inspect}"
    false
  end

  protected

  def validate!
    raise 'Слишком короткое название производителя' if company_name.size < 2
    raise 'Неверно задан тип вагона' unless type_valid?
  end

  def type_valid?
    return true if @type == :pass || @type == :cargo
    false
  end

  # показывает последний созданный вагон. нужно для добавления вагонов к поезду
  # через меню (class WagonMenu). юзеру не нужен этот метод
  def self.last
    @@all_wagons.last
  end
end
