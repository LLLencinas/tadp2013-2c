require_relative '../src/join_point_clases'
require_relative '../src/tenumeracion'

class JoinPointClasesEnumeracion < JoinPointClases

  include TEnumeracion
  attr_accessor :nombres

  def initialize(clases)
    @nombres = clases
  end

end