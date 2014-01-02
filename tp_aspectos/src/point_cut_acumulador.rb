class PointCutAcumulador
  attr_accessor :acumulado
  def initialize
     @acumulado=nil
  end
  def tiene_acumulado?
    !@acumulado.nil?
  end
  def acumular(pc)
    @acumulado = pc
  end
end