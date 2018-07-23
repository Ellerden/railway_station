# encoding: UTF-8

require_relative 'train'
require_relative 'main_menu'
require_relative 'manufacturer'
# Создание и управление вагонами всех типов
class Wagon
  include Manufacturer
  attr_reader :type
  @@all_wagons = []

  def initialize(manufacturer)
    self.company_name = manufacturer
    validate!
    @@all_wagons << self
  end

  protected

  def validate!
    unless valid?
      raise 'Не задано или слишком короткое название фирмы-производителя'
    end
  end

  def valid?
    unless company_name.nil? || company_name.size < 2
      return true
    end
      false
  end

  # показывает последний созданный вагон. нужно для добавления вагонов к поезду
  # через меню (class WagonMenu). юзеру не нужен этот метод
  def self.last
    @@all_wagons.last
  end
end
