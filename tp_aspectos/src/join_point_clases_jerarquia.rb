require_relative '../src/join_point_clases'
class JoinPointClasesJerarquia < JoinPointClases

  attr_accessor :expresion

  def initialize(clase_padre)
    @clase_padre_en_jerarquia=clase_padre
  end

  def evaluar(clase)
    clase.ancestors.include?(@clase_padre_en_jerarquia)


  end

end