# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'

class Wagon
  attr_reader :type
  @@all_wagons = []

  def self.menu
    "Выберите операцию: 1 - создать вагон, 2 - прицепить вагон к поезду, "\
    "3 - отцепить вагон от поезда. 0 - назад"
  end

  def self.do_from_menu(choice)
    case choice

      # создать вагон
      when 1
        puts "Выберите тип вагона, который вы хотите создать: 1 - пасс, 2 - груз"
        type = gets.chomp.to_i
        if type == 1
          @@all_wagons << PassengerWagon.new
          puts "Пассажирский вагон создан"
        elsif type == 2
          @@all_wagons << CargoWagon.new
          puts "Грузовой вагон создан"
        end

      # добавить вагон к поезду
      when 2
        puts "Введите название поезда, к которому цеплять вагон. "\
        " К поезду будет прицеплен последний созданный вагон"
        name = gets.chomp
        selected_train = Train.find_train_by_name(name)
        unless selected_train.nil?
          selected_train.attach_wagon(@@all_wagons.last)
          puts "Вагон прицеплен"
        end

      # отцепить вагон от поезда
      when 3
        puts "Введите название поезда, от которого отцеплять вагон. "\
        "Будет отцеплен последний вагон в поезде"
        name = gets.chomp
        selected_train = Train.find_train_by_name(name)
        unless selected_train.nil?
          selected_train.detach_wagon
          puts "Вагон отцеплен"
        end
      # возвращаемся в главное меню ж/д станции
      when 0
        MainMenu.show
    end
  end
end
