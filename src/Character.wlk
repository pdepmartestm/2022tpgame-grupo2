import wollok.game.*
import juego.*

class Imprimible {
	var property position
	var property image
	
	method colisionJugador(){}
  	
  	method colisionBala(bala){}
  	
  	method colisionEnemigo(){}
	
}
class Vida inherits Imprimible (image = "heartRed.png"){
	method morir(){
		image = "heartGrey.png"
	}
	
}
class Character inherits Imprimible{
	
	var sonidoDestroy
	const tiempoDeathSound
	
	method destroy() {
		sonidoDestroy.play()
		game.schedule(tiempoDeathSound,{sonidoDestroy.stop()}) //Para que pare el sonido
		self.salirDelTablero()
	}
	method verificarLimitaciones(){
		if(	position.x() < 0 || 
			position.x() > juego.pantallaX() ||
			position.y() < 0 || 
			position.y() > juego.pantallaY()
		){
			self.salirDelTablero()
		}
	}
	method salirDelTablero(){
		self.removermeDeListas()
		game.removeVisual(self)
	}
	method removermeDeListas(){}
}
