class Traje inherits ObjetoDefensivo{
	method protegerDe(unDanio){
		return if(self.estaGastado()) 0 else {unDanio * self.factorDeProteccion()}
	}
	
	method factorDeProteccion()
	
	method boostearExperiencia(){
		return 1
	}
	
	method estaGastado() = desgaste == 100
}

class Comun inherits Traje{
	const porcentajeDeProteccion
	override method factorDeProteccion(){
		return porcentajeDeProteccion/100
	}
	
	
}

class Entrenamiento inherits Traje{
	override method factorDeProteccion(){
		return 0
	}
	
	override method boostearExperiencia(){
		return industriaDeTrajes.boostExperiencia()
	}
}

object industriaDeTrajes{
	method boostExperiencia() = 2
}

class Modularizado inherits Traje{
	const piezas = new List()
	override method factorDeProteccion(){
		self.piezasNoGastadas().sum{unaPieza => unaPieza.resistencia()}
	}
	
	override method recibirAtaque(){
		piezas.forEach{unaPieza => unaPieza.recibirAtaque()}
	}
	
	method piezasNoGastadas() = piezas.filter{unaPieza => not unaPieza.estaGastada()}

	override method estaGastado() = piezas.all{unaPieza => unaPieza.estaGastado()}
	
	override method boostearExperiencia(){
		return self.porcentajeDePiezasNoGastadas()
	}
	
	method porcentajeDePiezasNoGastadas(){
		return self.piezasNoGastadas()/ piezas.size()
	}
}

class Pieza inherits ObjetoDefensivo{
	
	method estaGastado(){
		return desgaste >= 20
	}	
}

class ObjetoDefensivo{
	var desgaste = 0
	
	method recibirAtaque(){
		self.aumentarDesgasteEn(5)
	}
	
	method aumentarDesgasteEn(unaCantidad){
		desgaste = 100.min(desgaste+unaCantidad)
	}
}