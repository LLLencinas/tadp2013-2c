require_relative '../src/aspecto'
require_relative '../src/advice_cacheador'
require_relative '../src/join_point_clases_enumeracion'
require_relative '../test/clases_para_probar/sumadora'
require 'test/unit'

class AspectoCacheableTest < Test::Unit::TestCase


  def setup
    point_cut = JoinPointClasesEnumeracion.new([Sumadora])
    advice = AdviceCacheador.new()
    @cacheable = Aspecto.new(point_cut,advice)
    @cacheable.aplicar()
  end

   # Ya se que esta horrible hacer esto, pero no se como deshacer el efecto de test a test.

  def test_al_aplicar_aspecto_cacheable_y_ejecutar_un_metodo_afectado_se_guarda_en_memoria_cache_de_la_clase


    resultado_original_sumar = Sumadora.new().sumar(1,2,3)
    resultado_cacheado_sumar = Sumadora.cache.memoria.at(0).resultado
    resultado_sumar_que_se_cacheo = Sumadora.new().sumar(1,2,3)

    assert_equal resultado_cacheado_sumar, resultado_original_sumar
    assert_equal resultado_cacheado_sumar, resultado_sumar_que_se_cacheo
  end
  def test_al_aplicar_aspecto_cacheable_lo_guarda_en_la_cache_con_metodo_de_aridad_uno_y_revisa_que_el_objeto_resultado_sea_el_mismo_que_el_cacheado

    resultado_original_sumar_el_mismo = Sumadora.new().sumar_el_mismo(1)
    resultado_cacheado_sumar_el_mismo = Sumadora.cache.memoria.at(0).resultado
    resultado_sumar_el_mismo_que_se_caheo = Sumadora.new().sumar_el_mismo(1)

    assert (resultado_original_sumar_el_mismo == resultado_cacheado_sumar_el_mismo)
    assert (resultado_cacheado_sumar_el_mismo.equal? resultado_sumar_el_mismo_que_se_caheo)
  end
  def teardown
    @cacheable.desaplicar
    Sumadora.limpiar_cache
  end
end