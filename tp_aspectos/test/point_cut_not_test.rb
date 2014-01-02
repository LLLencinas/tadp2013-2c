require 'test/unit'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../src/join_point_clases_enumeracion'
require_relative '../src/join_point_metodos_aridad'
require_relative '../src/point_cut_not'


class PointCutNotTest < Test::Unit::TestCase

  def setup
    jparidad2 = JoinPointMetodosAridad.new(2)
    jp_clase_prueba = JoinPointClasesEnumeracion.new([ClasePrueba])
    @pcnot_aridad_2 = PointCutNot.new(jparidad2)
    @pcnot_clase_prueba = PointCutNot.new(jp_clase_prueba)
  end

  def test_pc_not_trae_todos_los_metodos_de_aridad_distinta_a_2
    metodos = @pcnot_aridad_2.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_aridad_3)])
  end

  def test_pc_not_no_trae_ningun_metodo_porque_todos_cumplen
    metodos = @pcnot_clase_prueba.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [])
  end


end