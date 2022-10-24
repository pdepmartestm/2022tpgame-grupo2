import wollok.game.*
import Character.* 
import Bala.*
import juego.*

class Jugador inherits Character{
  var property vida = 3
  const tiempoSprint = 75
  const property balas = []
  var property armaActual = bala
  
  method cambiarImagen(){ //Hacerlo generico con un for y concatenacion
  	game.onTick(300, "sprint", {
  	
  	game.schedule(tiempoSprint, {image = "jugador1.png"})
 	game.schedule(tiempoSprint*2, {image = "jugador2.png"})
 	game.schedule(tiempoSprint*3, {image = "jugador3.png"})
 	game.schedule(tiempoSprint*4, {image = "jugador4.png"})
  	})
  }
  
  method cambiarArma(nuevaArma){
  	armaActual = nuevaArma
  }
  
  
  method disparar(){
  	if(vida > 0){
  		const bala = armaActual.disparar(position)
  		game.addVisual(bala)
  		balas.add(bala)	
  	}	
  }
  
  override method colisionEnemigo(){
    		
    if(vida == 3){
    	juego.vida3().morir()
    }
    else if(vida == 2){
    	juego.vida2().morir()
    }
    else if(vida == 1){
    	juego.vida1().morir()
    }
    		
    vida = vida - 1
    		
    if(vida == 0){
    	juego.game_Over()
    	self.destroy()
    }
  }
}
	