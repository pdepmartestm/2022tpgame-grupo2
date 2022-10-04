import wollok.game.*
import Jugador.*
import Enemigo.*
import Character.*

object juego{
	var property tiempoDeSpawn = 3000
	const pantallaX = 23
	const pantallaY = 14
	const property enemigos = []
	
  	method iniciar(){
  		game.width(pantallaX)
  		game.height(pantallaY)
  		game.cellSize(50)
  		game.title("Juego")
  	
  		game.addVisualCharacter(jugador)
  		
  	
  		game.schedule(10, {musicaDeFondo.play()
  		musicaDeFondo.shouldLoop(true)})
  	
  		//COLISION CON ENEMIGOS
  	
  		game.whenCollideDo(jugador, { elemento => 
    		game.say(jugador, "Auch")
    		jugador.vida(jugador.vida() - 1)
    		if(jugador.vida() == 0){
    			jugador.destroy()
    		}
    		enemigos.remove(elemento)
    		elemento.destroy()
  		})
  		
  		//SPAWNEAR ENEMIGOS
  		self.spawnearEnemigos()
  		//MOVER ENEMIGOS
  		game.onTick(500, "moverse", {enemigos.forEach(	{e => e.moverse()
  														if(e.position().x() < 0){enemigos.remove(e) game.removeVisual(e)}
  														})	} )
  		//SPRINT ENEMIGOS
  		enemigos.forEach({e => e.cambiarImagen()})
  		game.onTick(800, "sprint", {enemigos.forEach({e => e.cambiarImagen()})})
  		//SPRINT JUGADOR
  		jugador.cambiarImagen()
  		game.onTick(300, "sprint", {jugador.cambiarImagen()})
  	}
  
  	method spawnearEnemigos(){
  		game.onTick(tiempoDeSpawn, "crearEnemigo", {
  			const enemigo = new Enemigo(image = "enemigo1.png", 
  										position = game.at(pantallaX - 1, 0.randomUpTo(pantallaY)), 
  										irAbajo = 0.randomUpTo(1),
  										sonidoDestroy = game.sound("alienDeath.wav"),
  										tiempoDeathSound = 300
  										)
  			game.addVisual(enemigo)
  			enemigos.add(enemigo)										
  		})
  	}
}

//SONIDOS
const musicaDeFondo = game.sound("BackgroundSound.mp3")
//JUGADORES
const jugador = new Jugador(image = "jugador1.png", 
							position = game.origin(), 
							sonidoDestroy = game.sound("death.wav"),
							tiempoDeathSound = 1000
							)
//OBJETOS
