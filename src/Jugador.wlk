import wollok.game.*
import Character.* 
import Bala.*

class Jugador inherits Character{
  var property vida = 3
  const tiempoSprint = 75
  const property balas = []
  method cambiarImagen(){ //Hacerlo generico con un for y concatenacion
  	game.schedule(tiempoSprint, {image = "jugador1.png"})
 	game.schedule(tiempoSprint*2, {image = "jugador2.png"})
 	game.schedule(tiempoSprint*3, {image = "jugador3.png"})
 	game.schedule(tiempoSprint*4, {image = "jugador4.png"})
  }
  
  method disparar(){
  	if(vida > 0){
  		const bala = new Bala(image = "bala.png", 
  										position = position.right(1),
  										sonidoDestroy = game.sound("impactoBala.wav"),
  										tiempoDeathSound = 300
  										)
  		game.addVisual(bala)
  		balas.add(bala)	
  	}	
  }
}