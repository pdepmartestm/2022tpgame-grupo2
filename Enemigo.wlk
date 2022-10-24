import wollok.game.*
import Character.*
import juego.* 

class Enemigo inherits Character (position = game.at(juego.pantallaX() - 1, 0.randomUpTo(juego.pantallaY())), 
  								  sonidoDestroy = game.sound("alienDeath.wav")){
  	var vida
  	var tipoMovimiento
  	var cantSprint
  	var SprintHint
 	
 	override method colisionBala(bala){
 		bala.colisionEnemigo()
 		vida--
 		if(vida <= 0){
    		self.destroy()
 		}
 		
 	}
 	override method colisionJugador(){
 		juego.jugador().colisionEnemigo()
    	juego.enemigos().remove(self)
    	self.destroy()
 	}
 	override method removermeDeListas(){
 		juego.enemigos().remove(self)
 	}
 	
 	method moverse(){
 		self.verificarLimitaciones()
 		position = tipoMovimiento.mover(position) 
 	}
 	method cambiarImagen(){ 
		cantSprint.times({b => game.schedule((800/cantSprint) * b, {image = SprintHint+ b +".png"})})
 	}
}


class Alien inherits Enemigo (image = "enemigo1.png", tiempoDeathSound = 300, vida = 2, tipoMovimiento = movimientoAlternado, cantSprint = 16, SprintHint = "enemigo"){
	var irAbajo
	override method moverse(){
		self.verificarLimitaciones()
		self.verificarSentido()
 		position = tipoMovimiento.mover(position, irAbajo) 
	}
	method verificarSentido(){
 		if( position.y() <= 1 ){
 			irAbajo = false
 		}
 		if( position.y() >= 13){
 			irAbajo = true
 		}
 	}
	
}


object movimientoAlternado{
	
	method mover(position, irAbajo){
		if(irAbajo == true){	return  position.down(1).left(1)}
 		else{	return  position.up(1).left(1)}
 	}
} 

object movimientoRectilineoIzquierdo{
	method mover(position){
		return  position.left(1)
 	}
}

object movimientoDirigido{
	method mover(position){
		const pos = juego.jugador().position()
 			if(position.x() > pos.x()){
 				if(pos.y() < position.y()){
 					return position.down(1).left(1)
 				}
 				else if(pos.y() > position.y()){
 					return position.up(1).left(1)
 				}
 				else {
 					return position.left(1)
 				}	
 			}
 			else if (position.x() < pos.x()){
 				if(pos.y() < position.y()){
 					return position.down(1).right(1)
 				}
 				else if(pos.y() > position.y()){
 					return position.up(1).right(1)
 				}
 				else {
 					return position.right(1)
 				}	
 			}
 			else {
 				if(pos.y() < position.y()){
 					return position.down(1)
 				}
 				else{
 					return position.up(1)
 				}
 			}
	}
}