import habitaciones.*

class Persona {
	var edad
	var property duermeEnElDormitorio
	var property tieneHabilidadEnCocina = false
	var property habitacionPrevia
	var property habitacionNueva
	var property nivelDeConfort 
	var property pudoEntrar = true
	method edad() = edad 
	method duermeEn(unDormitorio) = duermeEnElDormitorio == unDormitorio 
	method esMenorOIgualDe(unaEdad) = edad <= unaEdad
}

class Obsesivos inherits Persona {
	method seSienteAGusto(casa, familia) = self.pudoEntrar() and casa.habitaciones().all({habitacion => habitacion.ocupantes() <= 2})
}

class Golosos inherits Persona {
	method seSienteAGusto(casa, familia) = self.pudoEntrar() and familia.integrantesDeLaFamilia().any({integrante => integrante.tieneHabilidadEnCocina()})
}

class Sencillos inherits Persona {
	method seSienteAGusto(casa, familia) = self.pudoEntrar() and casa.habitaciones().size() > familia.integrantesDeLaFamilia().size()
}