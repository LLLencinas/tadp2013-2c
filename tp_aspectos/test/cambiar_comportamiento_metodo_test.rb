require 'test/unit'
require_relative '../../tp_aspectos/src/advice'


class CambiarComportamientoMetodoTest < Test::Unit::TestCase


  class Foo
    def metodo
      1
    end

    def metodo_suma_argumentos(a,b,c)
      a+b+c
    end
  end

  def setup

    @el_advice = Advice.new
    @foo=Foo.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def test_es_uno_antes_de_redefinir_el_metodo_y_despues_es_dos
    assert_equal 1,@foo.metodo
    @el_advice.modificar_metodo(Foo.instance_method(:metodo),Proc.new {2})
    assert_equal 2,@foo.metodo
    assert_equal 1,@foo.__metodo__
  end

  def test_cachea
    assert_equal 6,@foo.metodo_suma_argumentos(1,2,3)
    @el_advice.modificar_metodo(Foo.instance_method(:metodo_suma_argumentos),

                                Proc.new {|*argumentos|
                                        argumentos.min
                                        method(:__metodo_suma_argumentos__).call(1,2,3)
                                })
    assert_equal 6,@foo.metodo_suma_argumentos(1,2,3)
    assert_equal 6,@foo.__metodo_suma_argumentos__(1,2,3)
  end

end


class A
  def met(a,s)
    local_variables.each do |var|
      puts eval var.to_s
    end
  end
end