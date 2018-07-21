# encoding: UTF-8
module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    # возвращает кол-во экземпляров данного класса
    def instances
      @count = 0 if @count.nil?
      @count
    end
  end

  protected
  module InstanceMethods
    attr_accessor :count
    # увеличивает счетчик кол-ва экземпляров класса
    def register_instance
      self.class.count = 0 if self.class.count.nil?
      self.class.count += 1
    end
  end
end


