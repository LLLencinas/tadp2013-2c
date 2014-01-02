require_relative '../src/join_point_metodos'

class JoinPointMetodosNombreDeParametro < JoinPointMetodos
  attr_accessor :nombre

  def initialize(nombre)
    #String con nombre del parametro del metodo que queres afectar
    @clase_padre_en_jerarquia = nombre
  end

  def evaluar(metodo)
    metodo.parameters.any? {|tipo,nombre| nombre.to_s == @clase_padre_en_jerarquia }
  end

end