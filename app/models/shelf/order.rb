# encoding: utf-8
#
# ShelfOrder: ordena una collección de listas a partir de un parámetro del request
#
class Shelf::Order
  PARAMS = ['activas', 'alfabetico', 'original']
  NAMES = ['Más activas primero', 'Alfabético', 'Según fueron añadidas']

  def initialize(param)
    @param = PARAMS.include?(param) ? param : PARAMS[0]
  end

  def each
    PARAMS.each_with_index do |param, index|
      yield param, NAMES[index]
    end
  end

  def current?(param)
    @param == param
  end

  def order(collection)
    if @param == 'activas'
      collection.order('updated_at DESC')
    elsif @param == 'original'
      collection.order('id ASC')
    elsif @param == 'alfabetico'
      collection.order('name ASC')
    end
  end

end


