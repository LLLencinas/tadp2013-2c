require_relative '../src/advice'
class AdviceColeccion < Advice
  attr_reader :advices
  def initialize
    @advices=[]
  end
  def agregar_advice (otro_advice)
    @advices << otro_advice
  end
  def afectar_metodo(metodo)
    @advices.each do
      |un_advice| un_advice.afectar_metodo(metodo)
    end



  end
end