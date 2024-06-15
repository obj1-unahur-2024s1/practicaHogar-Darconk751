import personas.*

class Habitacion { 
	const ocupantes = []
	method ocupantes() = ocupantes
	method cantidadDeOcupantes() = ocupantes.size()
	method puedeEntrar(unaPersona)
	method nivelDeConfortQueOfreceA(unaPersona) = 10
	method estaVacia() = ocupantes.isEmpty() //Indica si la habitación está vacía
	method agregarOcupante(unaPersona){
		unaPersona.habitacionPrevia().ocupantes().remove(unaPersona)
		unaPersona.pudoEntrar(true)
		unaPersona.habitacionPrevia(self)
		unaPersona.habitacionNueva(self)
		ocupantes.add(unaPersona)
	}
}

class HabitacionDeUsoGeneral inherits Habitacion {
	override method puedeEntrar(unaPersona) = true 
}

class HabitacionDeDormitorio inherits Habitacion {
 	var property cantidadDePersonasQueDuermenEnElDormitorio
 	override method nivelDeConfortQueOfreceA(unaPersona) = super(unaPersona) + 
	if(unaPersona.duermeEn(self)) 
		10 / self.cantidadDePersonasQueDuermenEnElDormitorio() else 0
	override method puedeEntrar(unaPersona) {
		return unaPersona.duermeEn(self) or ocupantes.all({persona => persona.todosOcupantesDuermen() or self.estaVacia()})
	}
	method todosOcupantesDuermen() = ocupantes.count({persona => persona.duermeEn(self)}) == cantidadDePersonasQueDuermenEnElDormitorio
	method ocupanteMasViejo() = ocupantes.max({persona => persona.edad()})
	override method agregarOcupante(unaPersona){
		if (self.estaVacia() or self.puedeEntrar(unaPersona))
			super(unaPersona)
	}
}

class Banio inherits Habitacion {
	 override method nivelDeConfortQueOfreceA(unaPersona) = super(unaPersona) + if(unaPersona.edad() <= 4) 2 else 4
	 method hayUnNinio() = ocupantes.any({persona => persona.esMenorOIgualDe(4)})
	 override method puedeEntrar(unaPersona) = self.estaVacia() or self.hayUnNinio()
	 override method agregarOcupante(unaPersona){
	 	if (self.estaVacia() or self.puedeEntrar(unaPersona))
			super(unaPersona)
	}
}

class Cocina inherits Habitacion {
	const property metrosCuadradosDeLaCocina
	override method nivelDeConfortQueOfreceA(unaPersona) = super(unaPersona) + if (unaPersona.tieneHabilidadEnCocina()) metrosCuadradosDeLaCocina * configurarValorDeCocina.porcentajeDeConfortDeCocina() else 0 
	override method puedeEntrar(unaPersona) = self.estaVacia() or (not self.existeAlgunCocinero() and unaPersona.tieneHabilidadEnCocina())
	method existeAlgunCocinero() = ocupantes.any({persona => persona.tieneHabilidadEnCocina()})
	override method agregarOcupante(unaPersona){
		if (self.estaVacia() or self.puedeEntrar(unaPersona))
			super(unaPersona)
	}
}

object configurarValorDeCocina {
	var property porcentajeDeConfortDeCocina = 0.1
}