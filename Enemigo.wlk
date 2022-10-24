import wollok.game.*
import Character.*
import juego.* 

class Enemigo inherits Character {
  	var tiempoSprint = 50
  	var vida
 	
 	override method colisionBala(bala){
 		bala.colisionEnemigo()
 		vida = vida - bala.funcionamiento().vida()
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
}

class Alien inherits Enemigo {
	var irAbajo
	
	method moverse(){
 			self.verificarSentido()
 			if(irAbajo == 1){position = position.down(1).left(1)}
 			else{position = position.up(1).left(1)}
 	}
 	method verificarSentido(){
 		if( position.y() <= 0 ){
 			irAbajo = 0
 		}
 		if( position.y() >= 13){
 			irAbajo = 1
 		}
 	}
	
	method cambiarImagen(){ 
 		game.schedule(tiempoSprint, {image = "enemigo3.png"})
 		game.schedule(tiempoSprint*2, {image = "enemigo4.png"})
 		game.schedule(tiempoSprint*3, {image = "enemigo5.png"})
 		game.schedule(tiempoSprint*4, {image = "enemigo6.png"})
 		game.schedule(tiempoSprint*5, {image = "enemigo7.png"})
 		game.schedule(tiempoSprint*6, {image = "enemigo8.png"})
 		game.schedule(tiempoSprint*7, {image = "enemigo9.png"})
 		game.schedule(tiempoSprint*8, {image = "enemigo10.png"})
 		game.schedule(tiempoSprint*9, {image = "enemigo11.png"})
 		game.schedule(tiempoSprint*10, {image = "enemigo12.png"})
 		game.schedule(tiempoSprint*11, {image = "enemigo13.png"})
 		game.schedule(tiempoSprint*12, {image = "enemigo14.png"})
 		game.schedule(tiempoSprint*13, {image = "enemigo15.png"})
 		game.schedule(tiempoSprint*14, {image = "enemigo16.png"})
 		game.schedule(tiempoSprint*15, {image = "enemigo1.png"})
 		game.schedule(tiempoSprint*16, {image = "enemigo2.png"})
 	}
}

class Ufo inherits Enemigo {
	
	method moverse(){
 			self.verificarLimitaciones()
 			position = position.left(1)		
 	}
	
	method cambiarImagen(){ 
 		game.schedule(tiempoSprint, {image = "U2.png"})
 		game.schedule(tiempoSprint*2, {image = "U3.png"})
 		game.schedule(tiempoSprint*3, {image = "U4.png"})
 		game.schedule(tiempoSprint*4, {image = "U5.png"})
 		game.schedule(tiempoSprint*5, {image = "U6.png"})
 		game.schedule(tiempoSprint*6, {image = "U1.png"})
 	}
}

class NaveX inherits Enemigo {
	
	method moverse(){
 			self.verificarLimitaciones()
 			position = position.down(1)
 			/*const posY = juego.jugador().position().y()
 			if(posY < position.y()){
 				position = position.down(1).right(1)
 			}
 			else if(posY > position.y()){
 				position = position.up(1).right(1)
 			}
 			else if(posY == position.y()){
 				position = position.right(1)
 			}*/		
 	}
	
	method cambiarImagen(){ 
 		game.schedule(tiempoSprint, {image = "B2.png"})
 		game.schedule(tiempoSprint*2, {image = "B3.png"})
 		game.schedule(tiempoSprint*3, {image = "B4.png"})
 		game.schedule(tiempoSprint*4, {image = "B5.png"})
 		game.schedule(tiempoSprint*5, {image = "B6.png"})
 		game.schedule(tiempoSprint*6, {image = "B7.png"})
 		game.schedule(tiempoSprint*7, {image = "B8.png"})
 		game.schedule(tiempoSprint*8, {image = "B9.png"})
 		game.schedule(tiempoSprint*9, {image = "B10.png"})
 		game.schedule(tiempoSprint*10, {image = "B1.png"})
 	}
}