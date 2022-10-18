import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	
var property funcionamiento
	
	method moverse(){
		funcionamiento.velocidad().times({n =>
		self.verificarLimitaciones()
		position = position.right(1)
		/*NECESITO PODER CHEQUEAR POR CADA POSICION NUEVA SI HAY COLISIONADO CON ALGO*/
		game.colliders(self).forEach({enemigo =>enemigo.colisionBala(self)})
		})
 	}
 	
 	override method colisionEnemigo(){
  		/*game.whenCollideDo(self, { objeto => 
    								  objeto.colisionBala()
    								  self.destroy()})*/
    	self.destroy()
  	}
  	
  	override method removermeDeListas(){
 		juego.jugador().balas().remove(self)
 	}
}

object bala {
	var property velocidad = 4
	var property image = "bala.png"
	var property icon = "balaIcon.png"
}

object bomba {
	var property velocidad = 2
	var property image = "bomba.png"
	var property icon = "bombaIcon.png"
}

object misil {
	var property velocidad = 1
	var property image = "misil.png"
	var property icon = "misilIcon.png"
}