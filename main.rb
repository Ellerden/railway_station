require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/cargo_train'
require_relative 'lib/wagon'
require_relative 'lib/passenger_wagon'
require_relative 'lib/cargo_wagon'
require_relative 'lib/main_menu'
require_relative 'lib/station_menu'
require_relative 'lib/route_menu'
require_relative 'lib/train_menu'
require_relative 'lib/wagon_menu'
require_relative 'lib/ticket_menu'
include MainMenu

puts 'Добро пожаловать на железную дорогу. Что вы хотите сделать?'
MainMenu.show
