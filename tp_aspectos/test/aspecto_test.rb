require_relative '../src/join_point_clases_enumeracion'
require_relative '../src/join_point_metodos_aridad'
require_relative '../src/join_point_metodos_accessor'
require_relative '../src/point_cut_and'
require_relative '../src/aspecto'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/advice_bobo'
require 'test/unit'

class AspectoTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    point_cut = PointCutAnd.new([JoinPointClasesEnumeracion.new([ClasePrueba]),JoinPointMetodosAridad.new(2) ])
    advice_bobo = AdviceBobo.new()
    @aspecto_bobo = Aspecto.new(point_cut,advice_bobo)
  end

  def test_al_aplicar_el_aspecto_bobo_se_afectaran_los_metodos_de_aridad_2_de_la_clase_prueba
    metodos_que_se_afectaran = @aspecto_bobo.aplicar()
    assert_equal metodos_que_se_afectaran , [ClasePrueba.instance_method(:metodo_aridad_2), ClasePrueba.instance_method(:metodo_con_parametro_opcional)]
  end

  def test_al_aplicar_el_aspecto_bobo_se_agregara_a_los_aspectos_del_sistema
    @aspecto_bobo.aplicar()

    assert(Object.singleton_class.instance_variable_get(:@aspectos).include? @aspecto_bobo)
  end

end