import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	method moverse(){
 		position = position.right(1)
 	}
 	method verificarLimitaciones(){
 		if(position.x() < 0){
 			juego.jugador().balas().remove(self) 
 			game.removeVisual(self)
 		}
 	}
 	method colisionEnemigo(){
  		game.whenCollideDo(self, { enemigo => 
    								  juego.enemigos().remove(enemigo)
    								  enemigo.destroy()
    								  juego.jugador().balas().remove(self)
    								  self.destroy()})
  	}
}
