require_relative '../src/tenumeracion'
require_relative '../src/join_point_metodos'

class JoinPointMetodosEnumeracion < JoinPointMetodos

  include TEnumeracion
  def initialize(metodos)
    #coleccion de strings que son los nombres de los metodos que queremos afectar
    @nombres = metodos

  end


end