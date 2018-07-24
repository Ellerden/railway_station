# encoding: UTF-8

require_relative 'train'
require_relative 'main_menu'
require_relative 'manufacturer'
# Создание и управление вагонами всех типов
class Wagon
  include Manufacturer
  attr_reader :type
  # можно создать только объект субкласса PassengerWagon или CargoWagon
  private_class_method :new
  @@all_wagons = []

  def initialize(manufacturer)
    self.company_name = manufacturer
    validate!
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
    if company_name.size < 2
      raise 'Слишком короткое название фирмы-производителя'
    elsif (@type != :pass || @type != :cargo)
      raise 'Неверно задан тип вагона'
    end
  end

  # показывает последний созданный вагон. нужно для добавления вагонов к поезду
  # через меню (class WagonMenu). юзеру не нужен этот метод
  def self.last
    @@all_wagons.last
  end
end
