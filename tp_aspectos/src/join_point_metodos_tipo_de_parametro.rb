require_relative '../src/join_point_metodos'

class JoinPointMetodosTipoDeParametro < JoinPointMetodos

  def initialize(tipo)
    #tipo puede ser :opt :req  :rest
    @tipo = tipo
  end

  def evaluar(metodo)
    metodo.parameters.any? {|type,| type == @tipo }
  end

end