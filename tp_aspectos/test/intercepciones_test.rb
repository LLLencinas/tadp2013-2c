require 'test/unit'
require_relative '../../tp_aspectos/src/advice_intercepciones'
require_relative '../../tp_aspectos/test/clases_para_probar/prueba_intercepcion'
require_relative '../../tp_aspectos/src/aspecto'
require_relative '../../tp_aspectos/src/join_point_metodos_enumeracion'
class MyTest < Test::Unit::TestCase

  def setup
    point_cut = JoinPointMetodosEnumeracion.new(%w(metodo_interceptado))
    @advice = AdviceIntercepciones.new()
    @el_aspecto=Aspecto.new(point_cut,@advice)

    @el_objeto=PruebaIntercepcion.new

  end
  def test_before_se_ejecuta
    @advice.before =Proc.new{|instancia| instancia.atributo = instancia.atributo+1}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 11,@el_objeto.atributo

  end
  def test_instead_of_reemplaza_el_metodo
    @advice.instead_of = Proc.new{|instancia| instancia.atributo = 5}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 5,@el_objeto.atributo
  end
  def test_after_se_ejecuta
    @advice.after = Proc.new{|instancia| instancia.atributo = instancia.atributo - 3}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 7,@el_objeto.atributo
  end
  def test_hace_los_3_metodos_de_intercepcion
    @advice.before= Proc.new{|instancia| instancia.atributo = 5}
    @advice.instead_of = Proc.new{|instancia| instancia.atributo = instancia.atributo-3}
    @advice.after= Proc.new{|instancia| instancia.atributo = instancia.atributo + 16}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 18,@el_objeto.atributo
  end
  def test_on_error_hace_lo_que_tiene_que_hacer
    @advice.after= Proc.new{|instancia| 1/0}
    @advice.on_error= Proc.new{|instancia| instancia.atributo=25}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 25,@el_objeto.atributo
  end
  def test_si_on_error_no_esta_definido_raisea_el_error
    begin
      @advice.after= Proc.new{|instancia| 1/0}
      @el_aspecto.aplicar
      @el_objeto.metodo_interceptado
    rescue Exception => el_error
      assert_equal el_error.to_s, 'divided by 0'
    end
  end
  def test_los_3_metodos_interceptados_se_usan_en_el_orden_correspondiente
    @advice.before= Proc.new{|instancia| instancia.atributo = 5}
    @advice.instead_of = Proc.new{|instancia| if(instancia.atributo.eql?(5)) then instancia.atributo=6 end}
    @advice.after= Proc.new{|instancia|  if(instancia.atributo.eql?(6)) then instancia.atributo=7 end}
    @el_aspecto.aplicar
    @el_objeto.metodo_interceptado
    assert_equal 7,@el_objeto.atributo
  end

  def teardown
    @el_aspecto.desaplicar
  end

end