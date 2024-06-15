import habitaciones.*
import personas.*

class Casa {
	const property habitaciones = #{}
	method agregarhabitacion(unaHabitacion){
		habitaciones.add(unaHabitacion)
	}
	method habitacionesOcupadas() = habitaciones.filter({habitacion =>  not habitacion.estaVacia()})
	method responsablesDeLaCasa() = habitaciones.map({habitacion => habitacion.ocupanteMasViejo()})
}

class Familia {
	const property integrantesDeLaFamilia = #{}
	const property casaDondeViven
	
	method nivelDeConfortDeLaFamilia() = integrantesDeLaFamilia.sum({integrantes => integrantes.nivelDeConfort() / integrantesDeLaFamilia.size()})
	method estanAGusto() = self.nivelDeConfortDeLaFamilia() > 40 and integrantesDeLaFamilia.all({integrante => integrante.seSienteAGusto(casaDondeViven, self)})
}
