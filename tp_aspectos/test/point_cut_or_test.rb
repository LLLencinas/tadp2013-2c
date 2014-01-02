require 'test/unit'
require_relative '../src/join_point_clases_expresion_regular'
require_relative '../src/join_point_clases_enumeracion'
require_relative '../src/point_cut_or'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'

class PointCutOrTest < Test::Unit::TestCase

  def setup
  @jpexpresion_metodo = JoinPointClasesExpresionRegular.new(/Clase/)
  @jpenumeracion = JoinPointClasesEnumeracion.new([OtraPrueba])
  @pcor = PointCutOr.new([@jpexpresion_metodo, @jpenumeracion])
  @pcor_compuesto_pc_y_jp =  PointCutOr.new([@jpexpresion_metodo, @jpenumeracion,@pcor])
  end

  def test_point_cut_or_trae_metodos_de_clase_prueba_por_expresion_regular
    metodos = @pcor.traer_metodos_una_clase(ClasePrueba)
    metodos_assert = ClasePrueba.instance_methods(false).collect do
    |simbolo|
      ClasePrueba.instance_method(simbolo)
    end
    assert (metodos = metodos_assert)
  end

  def test_point_cut_or_trae_metodos_de_otra_prueba_por_enumeracion
    metodos = @pcor.traer_metodos_una_clase(OtraPrueba)
    metodos_assert = OtraPrueba.instance_methods(false).collect do
    |simbolo|
      OtraPrueba.instance_method(simbolo)
    end
    assert (metodos = metodos_assert)
  end

  def test_point_cut_or_no_trae_metodos_porque_no_cumple_enumeracion_ni_expresion
    metodos = @pcor.traer_metodos_una_clase(PointCutOrTest)
    assert (metodos == [])
  end

  def test_point_cut_or_compuesto_trae_metodos_de_clase_prueba_por_expresion_regular
    metodos = @pcor_compuesto_pc_y_jp.traer_metodos_una_clase(ClasePrueba)
    metodos_assert = ClasePrueba.instance_methods(false).collect do
    |simbolo|
      ClasePrueba.instance_method(simbolo)
    end
    assert (metodos = metodos_assert)
  end
end