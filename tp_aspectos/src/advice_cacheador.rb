require_relative '../src/advice'
require_relative '../src/cache'
require_relative '../src/metodo_argumentos_resultado'


class AdviceCacheador  < Advice

  def afectar_metodo(metodo)
    cacheador = crear_proc_cacheador(metodo)
    modificar_metodo(metodo,cacheador)


  end


  def crear_proc_cacheador(metodo)
    Proc.new{
      |*argumentos|

          cache = metodo.owner.get_cache()
          if  cache.se_ejecuto_previamente?(metodo, argumentos)
            begin
             resultado = cache.dame_resultado(metodo, argumentos)
            end

          else
            begin
              resultado = method("__#{metodo.name}__").call(*argumentos)
              cache.agregar_metodo_argumentos_resultado(MetodoArgumentosResultado.new(metodo, argumentos, resultado))
            end
          end

          resultado

          }

  end

end

class Class
  def get_cache
    if instance_variable_get(:@cache).nil?
      @cache = Cache.new
    else
      @cache
    end
  end
  def limpiar_cache
    @cache.limpiar
  end

  def cache
    @cache
  end

  def cache=(una_cache)
    @cache = una_cache
  end
end