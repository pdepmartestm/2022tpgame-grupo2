import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	
var property funcionamiento
var property recorrido = 1	

	method moverse(){
	/*self.verificarLimitaciones()
	position = position.right(1)*/
	if(funcionamiento.rango()>recorrido){
		self.verificarLimitaciones()
		recorrido++
		position = position.right(1)			
	 }	
	else{
		self.salirDelTablero()
		game.removeTickEvent("mover_balas")
	}
	
		


		/* VELOCIDADES
		 self.verificarLimitaciones()
		funcionamiento.velocidad().times({n =>
		self.verificarLimitaciones()
		position = position.right(1)
		//CHEQUEO DE ENEMIGOS QUE CHOCARON CON MI BALA (DUDOSO)
		game.objectIn(position)(self).forEach({enemigo =>enemigo.colisionBala(self) self.colisionEnemigo() self.removermeDeListas()})
		})
		 */
		 
 	}
 	override method verificarLimitaciones(){
		if(	position.x() < 0 || 
			position.x() > juego.pantallaX() ||
			position.y() < 0 || 
			position.y() > juego.pantallaY() ||
			funcionamiento.rango()<=recorrido
		){
			self.salirDelTablero()
		}
	}
 	
 	override method colisionEnemigo(){
    	self.destroy()
    	game.removeTickEvent("mover_balas")
  	}
  	
  	override method removermeDeListas(){
 		juego.jugador().balas().remove(self)
 	}
}

object bala {
	var property velocidad = 4
	var property vida = 1
	var property rango = 15
	var property image = "bala.png"
	var property icon = "balaIcon.png"
}

object bomba {
	var property velocidad = 2
	var property vida = 2
	var property rango = 10
	var property image = "bomba.png"
	var property icon = "bombaIcon.png"
}

object misil {
	var property velocidad = 1
	var property vida = 3
	var property rango = 5
	var property image = "misil.png"
	var property icon = "misilIcon.png"
}