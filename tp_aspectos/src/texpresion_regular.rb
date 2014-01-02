module TExpresionRegular

  attr_accessor :expresion
  def evaluar(elemento)
    self.expresion.match(elemento.to_s)
  end

end