import Traje.*

class Guerrero{
	var potencialOfensivo
	var energiaActual = 5000
	var experiencia = 0
	const property energiaOriginal
	var traje
	
	/* Punto 1 */
	method atacarA(unGuerrero){
		unGuerrero.recibirAtaque(self.potencialOfensivo())
	}
	
	method potencialOfensivo() = potencialOfensivo
	
	method recibirAtaque(unPotencial){
		self.disminuirEnergiaEn(self.danioARecibir(unPotencial))
		self.incrementarExperienciaEn(1)
		traje.recibirAtaque()
	}
	
	method danioARecibir(unPotencial){
		return self.danioBaseDeAtaque(unPotencial) - traje.protegerDe(unPotencial)
	}
	
	method danioBaseDeAtaque(unPotencial) = unPotencial * 0.1
	
	method disminuirEnergiaEn(unaCantidad){
		energiaActual = 0.max(energiaActual - unaCantidad)
	}
	
	method incrementarExperienciaEn(unaCantidad){
		experiencia += unaCantidad
	}
	
	method comerSemillaDelErmitanio(){
		energiaActual = energiaOriginal
	}
	
	/* Getters para los tests */
	method  energiaActual() = energiaActual
	method experiencia() = experiencia * traje.boostearExperiencia()
}


class Saiyan inherits Guerrero{
	var estado
	
	override method danioARecibir(unPotencial){
		return super(unPotencial) - estado.danioDeReduccion(unPotencial)
	}
	
	override method potencialOfensivo() = estado.potencialOfensivo(potencialOfensivo)
	
	override method comerSemillaDelErmitanio(){
		super()
		self.aumentarFuerzaEn(potencialOfensivo * 0.05)
	}
	
	method aumentarFuerzaEn(unaCantidad){
		potencialOfensivo += unaCantidad
	}
	
	override method disminuirEnergiaEn(unaCantidad){
		super(unaCantidad)
		self.chequearSiDebeVolverALaNormalidad()
	}
	
	method chequearSiDebeVolverALaNormalidad(){
		if(self.estaCritico()) self.transformarse(estandar)
	}
	
	method estaCritico() = energiaActual < self.saludCritica()
	
	method saludCritica() = energiaOriginal * 0.01
	
	method transformarse(unEstado){
		estado = unEstado
	}
}

object estandar{
	method danioDeReduccion(unPotencial) = 0
	
	method potencialOfensivo(unPotencial) = unPotencial
}

class SuperSaiyan{
	method danioDeReduccion(unPotencial) = unPotencial * self.valorPorcentual() / 100
	
	method valorPorcentual()
	
	method potencialOfensivo(unPotencial) = unPotencial * 2
}

object nivel1 inherits SuperSaiyan{
	override method valorPorcentual() = 5
}

object nivel2 inherits SuperSaiyan{
	override method valorPorcentual() = 7
}

object nivel3 inherits SuperSaiyan{
	override method valorPorcentual() = 15
}

/* Preguntas a Juli:
 * Los guerreros y los saiyans comparten casi todo, sólo que los saiyans tienen estados.
 * Hay un estado de los saiyans que es estándar que se comporta igual que un guerrero, no el estado en sí, pero lo que agrega hace que sea igual.
 * Hacer algo como template no me gustó pq si los guerreros no tienen estado, no agregarían nada a los métodos que se usen compartidos. Y si se le pone como estado el estandar,
 * le estas poniendo algo que capaz no necesita.
 * Entonces no sabía si lo que había pensado estaba bien y dejar a los saiyans que overrideen un par de métodos y listo, o si alguna de las opciones que había descartado era más viable
 * 
 * Después en los trajes, cuando llegue al traje que tiene múltiples piezas, cree una clase ObjetoDefensivo que acapare a los trajes y a las piezas pq me pareció que tenía sentido por el comportamiento
 * compartido en cuanto a recibirAtaques y la lógica del desgaste.
 * 
 */