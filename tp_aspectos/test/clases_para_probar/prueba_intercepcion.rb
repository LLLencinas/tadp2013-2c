class PruebaIntercepcion
  attr_accessor :atributo
  def initialize
    @atributo=0
  end
  def metodo_interceptado
    @atributo=@atributo+10
  end

  def before(*args)
    @atributo= @atributo + args[0]
  end
end