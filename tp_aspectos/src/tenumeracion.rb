module TEnumeracion

  attr_accessor :nombres

  def evaluar(elemento)
    self.nombres.include?(elemento.name.to_s) ||
    self.nombres.include?(elemento)

    #Con el or tenés la flexibilidad de encontrar por objeto o por nombre
  end

end