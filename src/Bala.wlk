import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
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
