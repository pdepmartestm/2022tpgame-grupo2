import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	
var property funcionamiento
	
	method moverse(){
	self.verificarLimitaciones()
	position = position.right(1)
		
		/* VELOCIDADES
		 self.verificarLimitaciones()
		funcionamiento.velocidad().times({n =>
		self.verificarLimitaciones()
		position = position.right(1)
		//CHEQUEO DE ENEMIGOS QUE CHOCARON CON MI BALA (DUDOSO)
		game.colliders(self).forEach({enemigo =>enemigo.colisionBala(self) self.colisionEnemigo() self.removermeDeListas()})
		})
		 */
		 
 	}
 	
 	override method colisionEnemigo(){
    	self.destroy()
  	}
  	
  	override method removermeDeListas(){
 		juego.jugador().balas().remove(self)
 	}
}

object bala {
	var property velocidad = 4
	var property vida = 1
	var property image = "bala.png"
	var property icon = "balaIcon.png"
}

object bomba {
	var property velocidad = 2
	var property vida = 2
	var property image = "bomba.png"
	var property icon = "bombaIcon.png"
}

object misil {
	var property velocidad = 1
	var property vida = 3
	var property image = "misil.png"
	var property icon = "misilIcon.png"
}