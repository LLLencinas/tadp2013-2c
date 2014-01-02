require_relative '../../tp_aspectos/src/advice'
require_relative '../../tp_aspectos/src/metodo_advice'
class AdviceIntercepciones < Advice
  attr_accessor :before, :after, :instead_of, :on_error
  def initialize( before=Proc.new{}, after=Proc.new{}, instead_of=nil, on_error=nil)
    @before = before
    @after= after
    @instead_of=instead_of
    set_on_error(on_error)

  end

  def set_on_error(on_error)
    if on_error.nil? then
      @on_error=Proc.new { |instancia, un_error, *argumentos| raise un_error.to_s}
    else
      @on_error=on_error
    end
  end

    def afectar_metodo(un_metodo,before=@before,after=@after,instead_of=@instead_of,on_error=@on_error, instancia=nil)
      modificar_metodo un_metodo, Proc.new{ MetodoAdvice.new(
          Proc.new{un_metodo.bind(self).call},
          before,
          after,
          instead_of,
          on_error).ejecutar_metodo(un_metodo.bind(self).receiver)
      }

    end

end