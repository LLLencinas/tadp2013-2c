class Aspecto

  attr_accessor :point_cut, :advice, :aplicado_dinamicamente

  def initialize(point_cut,advice)
    @point_cut = point_cut
    @advice = advice
    @aplicado=false
    self.no_aplicar_dinamicamente
  end

  def aplicar
    todas_las_clases = self.recopilar_todas_las_clases
    metodos_a_afectar = point_cut.traer_metodos_col_clases(todas_las_clases)
    self.agregar_aspecto_al_sistema(self)
    self.aplicar_advice(metodos_a_afectar)
    @aplicado=true
    @metodos_afectados=metodos_a_afectar
  end
  def desaplicar
    @el_advice = Advice.new()
    @metodos_afectados.each do
       |metodo| @el_advice.desafectar_metodo(metodo)
    end
    @metodos_afectados=[]
    @aplicado=false
    @aplicado_dinamicamente=false
  end

  def recopilar_todas_las_clases
    un_set = []
    ObjectSpace.each_object(Class) do |una_clase| un_set << una_clase end
    un_set.uniq
  end

  def aplicar_advice(metodos)
    @advice.afectar_metodos(metodos)

  end

  def procesar_metodo_agregado_dinamicamente(metodo)

    if (@aplicado_dinamicamente && @aplicado && self.evaluar(metodo))
      @advice.afectar_metodo(metodo)
      @metodos_afectados << metodo
    end
  end
  def aplicar_dinamicamente
    @aplicado_dinamicamente=true
  end
  def no_aplicar_dinamicamente
    @aplicado_dinamicamente=false
  end
end
class Object
  def agregar_aspecto_al_sistema(aspecto)
    aspectos = Object.singleton_class.instance_variable_get(:@aspectos)
    if aspectos.nil?
      Object.singleton_class.instance_variable_set(:@aspectos, [aspecto])
    else
      Object.singleton_class.instance_variable_set(:@aspectos, aspectos + [aspecto])
    end
  end
end

class Module
  alias_method :__define_method__, :define_method
  def define_method(*args)

    if args[1].nil?
      proc = Proc.new{}
    else
      proc = args[1]
    end

    __define_method__(args[0],proc)

    aspectos = Object.singleton_class.instance_variable_get(:@aspectos)

    if(!aspectos.nil?)
      aspectos.each do |aspecto|

        metodo_agregado = self.instance_method(args[0])
        aspecto.procesar_metodo_agregado_dinamicamente(metodo_agregado)
    end


    end
  end
end
