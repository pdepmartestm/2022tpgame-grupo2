import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
var property funcionamiento = bala
	
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
	var property velocidad = 3
	var property rango = 3
}

object bomba {
	var property velocidad = 2
	var property rango = 5
}

object misil {
	var property velocidad = 1
	var property rango = 10
}
