require_relative '../src/texpresion_regular'
require_relative '../src/join_point_metodos'

class JoinPointMetodosExpresionRegular < JoinPointMetodos

  # Aca podria venir bien un trait...
  include TExpresionRegular
  def initialize(expresion)
    @expresion = expresion
  end

end