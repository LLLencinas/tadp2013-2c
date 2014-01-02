require_relative '../src/texpresion_regular'
require_relative '../src/join_point_clases'

class JoinPointClasesExpresionRegular < JoinPointClases

  include TExpresionRegular

  def initialize(expresion)
    @expresion = expresion
  end

end