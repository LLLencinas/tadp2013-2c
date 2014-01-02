class Advice
  def modificar_metodo(un_metodo,el_proc)
    un_metodo.owner.send(:alias_method,"__#{un_metodo.name}__",un_metodo.name)
    un_metodo.owner.send(:__define_method__,un_metodo.name,el_proc)
      #alias_method "__#{un_metodo.to_s}__".to_sym,"#{un_metodo.to_s}".to_sym
      #def metodo (*args)
       # el_proc.call(*args)
      #end
  end
  def desafectar_metodo(un_metodo)
    un_metodo.owner.send(:alias_method,un_metodo.name,"__#{un_metodo.name}__")
  end

  def afectar_metodos(metodos)

    metodos.each do |metodo|
       afectar_metodo(metodo)
    end

  end


end