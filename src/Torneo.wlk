class Torneo{
	const jugadores
	method seleccionarJugadores(){
		return self.jugadoresOrdenadosSegunCriterio().take(16)
	}
	
	method jugadoresOrdenadosSegunCriterio()

}

class TorneoConCriterioArbitrario inherits Torneo{
	override method jugadoresOrdenadosSegunCriterio(){
		return jugadores.sortedBy{unJugador, otroJugador=> self.criterioPropio(unJugador) >  self.criterioPropio(unJugador)}
	}
	
	method criterioPropio(unJugador)
}

class PowerlsBest inherits TorneoConCriterioArbitrario{
	override method criterioPropio(unJugador){
		return unJugador.potencialOfensivo()
	}
}

class Funny inherits TorneoConCriterioArbitrario{
	override method criterioPropio(unJugador){
		return unJugador.cantidadDePiezas()
	}
}

class Surprise inherits Torneo{
	override method jugadoresOrdenadosSegunCriterio(){
		return self.armarListaAleatoria()
	}
	
	method armarListaAleatoria(){
		const jugadoresAleatorios = new List()
		jugadores.size().times{i => jugadoresAleatorios.add(jugadores.anyOne())}
		return jugadoresAleatorios
	}
}