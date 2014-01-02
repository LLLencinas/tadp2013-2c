require 'test/unit'
require_relative '../../tp_aspectos/src/codigo_dsl'
require_relative '../../tp_aspectos/src/aspecto'
require_relative '../../tp_aspectos/src/advice'
require_relative '../../tp_aspectos/src/aspecto_dsl'
require_relative '../../tp_aspectos/src/point_cut_dsl'
require_relative '../../tp_aspectos/test/clases_para_probar/prueba_intercepcion'
class MyTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end
  def test_dsl_no_se_rompe
    aspecto = modificar {si {cumple {tiene aridad 2}}}
    assert_equal aspecto.class, Aspecto
    assert_equal JoinPointMetodosAridad,aspecto.point_cut.class

  end
  def test_aspecto_dsl_crea_bien_el_pcdsl
    aspecto = AspectoDsl.new
    aspecto.si {cumple {tiene aridad 2}}
    el_aspecto_real=aspecto.crear_construccion
    assert_equal aspecto.tu_target,PointCutDsl
    assert_equal aspecto.tu_clase_a_buildear, PointCutDsl
    assert_equal el_aspecto_real.point_cut.class,JoinPointMetodosAridad
  end
  def test_aridad
    pcdsl = PointCutDsl.new
    pcdsl.cumple {tiene aridad 2}
    assert_equal pcdsl.tu_clase_a_buildear,CreadorJoinPoint
    assert_equal pcdsl.crear_construccion.class, JoinPointMetodosAridad
  end
  def test_acumula_con_y
    aspecto = modificar {si {cumple {tiene aridad 2}
                              y {tiene aridad 3}}}
    assert_equal aspecto.point_cut.class, PointCutAnd

  end
  def test_niega
    aspecto = modificar {si {cumple {no tiene aridad 2}
   }}
    assert_equal aspecto.point_cut.class, PointCutNot
  end

  def test_no_tiene_acumulado
    assert !PointCutAcumulador.new.tiene_acumulado?
  end
  def test_hace_el_advice
    aspecto = modificar {si {cumple {tiene aridad 2}
    o {tiene aridad 3}}
                          haciendo {antes{print 1}
                                    en vez {print 2}
                                    despues {print 3}
                                    con cache}}
    assert_equal AdviceColeccion,aspecto.advice.class
  end
  def test_anda_el_dsl_con_comportamiento_aplicado
    aspecto = modificar {si {cumple {de metodos %w(metodo_interceptado)}}
                          haciendo {antes {|instancia| instancia.atributo = 5}
                                    en vez {|instancia| instancia.atributo = instancia.atributo-3}
                                    despues {|instancia| instancia.atributo = instancia.atributo + 16}}}
    assert_equal AdviceColeccion,aspecto.advice.class
    assert_equal aspecto.advice.advices.first.class,AdviceIntercepciones
    aspecto.aplicar
    @el_objeto=PruebaIntercepcion.new
    @el_objeto.metodo_interceptado
    assert_equal 18,@el_objeto.atributo
  end
  def test_se_aplica_dinamicamente_y_le_pone_cache
    @el_objeto=PruebaIntercepcion.new
      aspecto = modificar {si {cumple {de metodos %w(metodo_interceptado)}}
      haciendo {cache}
      dinamicamente}
      assert_equal AdviceColeccion,aspecto.advice.class
      assert_equal aspecto.advice.advices.first.class,AdviceIntercepciones
      aspecto.aplicar

      @el_objeto.metodo_interceptado
      assert_equal 1, @el_objeto.class.cache.memoria.size
      assert_equal 18,@el_objeto.atributo
      assert aspecto.aplicado_dinamicamente

  end


  #def test_
    #modificar {si cumple {aridad 2}
    #y cumple { clase parecida a 'Prueb'}
    #y cumple { metodo parecido a 'metod'}
    #y cumple{esta en clases [ClasePrueba, ClasePrueba1, ClasePrueba2] }
    #y cumple{esta en metodos [:valor1, :nombre, :saludar] }
    #y cumple{es accesor}
    # y cumple{tiene parametro 'valor1'}
    # y cumple{tiene parametros opcionales}
    # y cumple{tiene parametros requeridos}
    # y cumple{}
    # y cumple{}
    # y cumple{}
    # y cumple{}
    # }
    #haciendo {
    #{antes {}
    #}despues {}
    #en vez {}
    #en error{}
    #con cache de mensajes
    #}
    #aplicado dinamicamente;}
  #end}
end