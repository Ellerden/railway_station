require_relative 'train'
require_relative 'main_menu'
require_relative 'wagon'
# покупка билетов и резервирование места для груза
class TicketMenu
  MENU_OPTIONS = ['Выберите операцию: 1 - купить билет на поезд, '\
             '2 - отправить груз. 0 - назад'].freeze
  MENU_METHODS = { 1 => :buy_ticket,
                   2 => :ship_package }.freeze

  def initialize
    puts MENU_OPTIONS
  end

  def do_from_menu(choice)
    send MENU_METHODS[choice] || return
  end
  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  # купить билет в пассажирский вагон
  def buy_ticket
    puts 'Введите номер поезда, в котором вы хотите купить билет. '
    name = gets.chomp
    selected_train = Train.find(name)
    return unless selected_train && selected_train.wagons &&
                  selected_train.type == :pass
    choose_wagon(selected_train, :pass)
    puts "Забронировано! Осталось мест: #{wagon.places - wagon.taken_places}"
  end

  def choose_wagon(train, _options = {})
    train.show_wagons_info
    puts 'Выберите номер вагона, в котором разместить груз или купить билет'
    num = gets.chomp.to_i
    wagon = train.wagons[num - 1]
    case options[:type]
    when :pass
      wagon.take_place
    when :cargo
      wagon.occupy_space(space)
    else
      return
    end
  end

  # отправить груз в грузовом вагоне
  def ship_package
    puts 'Введите номер поезда, в котором вы хотите отправить груз. '
    name = gets.chomp
    selected_train = Train.find(name)
    return unless selected_train && selected_train.wagons &&
                  selected_train.type == :cargo

    puts 'Введите объем груза'
    space = gets.chomp.to_i
    choose_wagon(selected_train, :cargo, space)
    puts 'Груз успешно добавлен! Осталось свободного объема: '\
      "#{wagon.capacity - wagon.taken_space} м^3"
  end
end
