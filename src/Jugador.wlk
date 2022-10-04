import wollok.game.*
import Character.* 

class Jugador inherits Character{
  var property vida = 3
  var tiempoSprint = 75
  method cambiarImagen(){ //Hacerlo generico con un for y concatenacion
  	game.schedule(tiempoSprint, {image = "jugador1.png"})
 	game.schedule(tiempoSprint*2, {image = "jugador2.png"})
 	game.schedule(tiempoSprint*3, {image = "jugador3.png"})
 	game.schedule(tiempoSprint*4, {image = "jugador4.png"})
  }
}