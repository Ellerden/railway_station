# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'

class Wagon
  attr_reader :type
  @@all_wagons = []

  def initialize
    @@all_wagons << self
  end

  protected
  # показывает последний созданный вагон. нужно для добавления вагонов к поезду
  # через меню (class WagonMenu). юзеру не нужен этот метод
  def self.last
    @@all_wagons.last
  end
end
