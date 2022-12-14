import wollok.game.*
import Character.* 
import Bala.*
import juego.*

class Jugador inherits Character{
  var property vida = 3
  const tiempoSprint = 75
  const property balas = []
  var property armaActual = bala
  //const sonidoDisparo = game.sound("disparo.wav")
  
  method cambiarImagen(){ //Hacerlo generico con un for y concatenacion
  	game.schedule(tiempoSprint, {image = "jugador1.png"})
 	game.schedule(tiempoSprint*2, {image = "jugador2.png"})
 	game.schedule(tiempoSprint*3, {image = "jugador3.png"})
 	game.schedule(tiempoSprint*4, {image = "jugador4.png"})
  }
  
  method cambiarArma(nuevaArma){
  	armaActual = nuevaArma
  }
  
  
  method disparar(){
  	if(vida > 0){

  		const bala = new Bala(			image = armaActual.image(), 
  										position = position.right(1),
  										sonidoDestroy = game.sound("impactoBala.wav"),
  										tiempoDeathSound = 300,
  										funcionamiento = armaActual
  										)
  		game.addVisual(bala)
  		
  		//Movimiento
  		balas.add(bala)
  		game.onTick(100 / bala.funcionamiento().velocidad() , "mover_balas", {bala.moverse()})					
  	  	game.whenCollideDo(bala, { enemigo =>  enemigo.colisionBala(bala)})
  	
  	}	
  }
  
  override method colisionEnemigo(){
  	game.say(self, "Auch")
    		
    if(vida == 3){
    	juego.vida3().image("heartGrey.png")
    }
    else if(vida == 2){
    	juego.vida2().image("heartGrey.png")
    }
    else if(vida == 1){
    	juego.vida1().image("heartGrey.png")
    }
    		
    vida --
    		
    if(vida == 0){
    	juego.gameOver()
    	self.destroy()
    }
  }
}