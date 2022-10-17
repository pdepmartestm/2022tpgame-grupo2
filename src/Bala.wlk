import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	
var property funcionamiento = misil
	
	method moverse(){
		self.verificarLimitaciones()
 		position = position.right(1)
 	}
 	
 	method verificarLimitaciones(){
 		if(position.x() > juego.pantallaX()){
 			juego.jugador().balas().remove(self) 
 			game.removeVisual(self)
 		}
 	}
 	
 	method colisionEnemigo(){
  		game.whenCollideDo(self, { objeto => 
    								  objeto.colision()
    								  juego.jugador().balas().remove(self)
    								  self.destroy()})
  	}
  	
  	method colisionJugador(){}
  	
  	method colision(){}
}

object bala {
	var property velocidad = 1
	var property rango = 3
	var property image = "bala.png"
	var property icon = "balaIcon.png"
}

object bomba {
	var property velocidad = 1000
	var property rango = 5
	var property image = "bomba.png"
	var property icon = "bombaIcon.png"
}

object misil {
	var property velocidad = 2000
	var property rango = 10
	var property image = "misil.png"
	var property icon = "misilIcon.png"
}