require 'test/unit'
require_relative '../src/join_point_clases_expresion_regular'
require_relative '../src/join_point_clases_enumeracion'
require_relative '../src/join_point_metodos_aridad'
require_relative '../src/point_cut_and'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'

class PointCutAndTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @jpexpresion_metodo = JoinPointClasesExpresionRegular.new(/Clase|Test/)
    @jpenumeracion = JoinPointClasesEnumeracion.new([ClasePrueba,OtraPrueba])
    @jparidad = JoinPointMetodosAridad.new(3)
    @pc_expresion_and_enumeracion = PointCutAnd.new([@jpexpresion_metodo, @jpenumeracion])
    @pc_aridad3_and_pc_enumeracion_and_expresion = PointCutAnd.new([@jparidad,  @pc_expresion_and_enumeracion])
  end

  def test_pc_and_trae_metodos_de_clase_prueba_porque_cumple_ambas
    metodos_a_afectar = @pc_expresion_and_enumeracion.traer_metodos_una_clase(ClasePrueba)
    metodos_assert = ClasePrueba.instance_methods(false).collect do
    |simbolo|
      ClasePrueba.instance_method(simbolo)
    end
    assert (metodos_a_afectar == metodos_assert)
  end

  def test_pc_and_no_trae_metodos_de_otra_prueba_porque_no_cumple_expresion_regular
    metodos_a_afectar = @pc_expresion_and_enumeracion.traer_metodos_una_clase(OtraPrueba)
    assert (metodos_a_afectar == [])
  end

  def test_pc_and_no_trae_metodos_de_point_cut_and_test_porque_no_esta_enumerada
    metodos_a_afectar = @pc_expresion_and_enumeracion.traer_metodos_una_clase(PointCutAndTest)
    assert (metodos_a_afectar == [])
  end

  def test_pc_compuesto_por_jp_y_pc_trae_metodo_de_aridad_3_de_clase_prueba
    metodos = @pc_aridad3_and_pc_enumeracion_and_expresion.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_aridad_3)])
  end

end