import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
	var potencia
	var tipoMovimiento
	
	method moverse(){
		self.verificarLimitaciones()
		position = tipoMovimiento.mover(position)
 	}
 	
 	override method colisionEnemigo(){
    	self.destroy()
  	}
  	
  	override method removermeDeListas(){
 		juego.jugador().balas().remove(self)
 	}
}

class BalaComun inherits Bala (image = "bala.png", potencia = 3, tipoMovimiento = movimientoRectilineo){
	
}

class Bomba  inherits Bala (image = "bomba.png", potencia = 2, tipoMovimiento = movimientoDiagonalAbajo){
	
}

class Misil inherits Bala (image = "misil.png", potencia = 1, tipoMovimiento = movimientoDiagonalArriba){
	 
}

object bala{
	var property icon = "balaIcon.png"
	method disparar(pos){
		return new BalaComun( 	position = pos.right(1),
  								sonidoDestroy = game.sound("impactoBala.wav"),
  								tiempoDeathSound = 300 )
	}
}

object bomba {
	var property icon = "bombaIcon.png"
	method disparar(pos){
		return new Bomba( 		position = pos.right(1),
  								sonidoDestroy = game.sound("impactoBala.wav"),
  								tiempoDeathSound = 300 )
	}
}

object misil {
	var property icon = "misilIcon.png"
	method disparar(pos){
		return new Misil( 		position = pos.right(1),
  								sonidoDestroy = game.sound("impactoBala.wav"),
  								tiempoDeathSound = 300 )
	}
}
object movimientoDiagonalArriba{
	method mover(position){
		return position.up(1).right(1)
	}
}
object movimientoRectilineo{
	method mover(position){
		return position.right(1)
	}
}
object movimientoDiagonalAbajo{
	method mover(position){
		return position.down(1).right(1)
	}
}