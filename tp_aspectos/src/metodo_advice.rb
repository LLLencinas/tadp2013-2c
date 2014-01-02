class MetodoAdvice
attr_accessor :before, :after, :instead_of, :on_error
  # Pasar los bloques como Proc.new({el bloque}), no como bloques pelados.

  def initialize(metodo_original,before=nil, after=nil, instead_of=nil, on_error=nil)
     @before = before
     @after = after

     @metodo_original = metodo_original
     set_instead_of(instead_of, metodo_original)
     set_on_error(on_error)

   end

  def set_on_error(on_error)
    if on_error.nil? then
      @on_error=Proc.new { |un_error, *argumentos| raise un_error}
    else
      @on_error=on_error
    end
  end

  def set_instead_of(instead_of, metodo_original)
    if instead_of.nil? then
      @instead_of = metodo_original
    else
      @instead_of = instead_of
    end
  end

def bind(instancia)
   puts @before.call(instancia),  @metodo_original.bind(instancia).call(),   @after.call(instancia)
    # @instead_of.call(instancia)
    # ver como mandar el on_error

  end

  def ejecutar_metodo(instancia,*argumentos)
    begin
      @before.call instancia, *argumentos
      @instead_of.call instancia, *argumentos
      @after.call instancia, *argumentos
    rescue Exception => el_error
      @on_error.call(instancia,el_error,*argumentos)
    end
  end

end
