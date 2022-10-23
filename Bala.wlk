import wollok.game.*
import Character.*
import juego.*
import Jugador.*

class Bala inherits Character{
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

object bala{
	var property icon = "balaIcon.png"
	method disparar(pos){
		return new Bala( 		image = "bala.png", 
								tipoMovimiento = movimientoRectilineo,
								position = pos.right(1),
  								sonidoDestroy = game.sound("impactoBala.wav"),
  								tiempoDeathSound = 300 )
	}
}

object bomba {
	var property icon = "bombaIcon.png"
	method disparar(pos){
		return new Bala( 		image = "bomba.png", 
								tipoMovimiento = movimientoDiagonalAbajo,
								position = pos.down(1),
  								sonidoDestroy = game.sound("impactoBala.wav"),
  								tiempoDeathSound = 300 )
	}
}

object misil {
	var property icon = "misilIcon.png"
	method disparar(pos){
		return new Bala( 		image = "misil.png", 
								tipoMovimiento = movimientoDiagonalArriba,
								position = pos.up(1),
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