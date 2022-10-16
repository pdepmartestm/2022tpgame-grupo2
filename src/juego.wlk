import wollok.game.*
import Jugador.*
import Enemigo.*
import Character.*
import Vida.*

object juego{
	var property tiempoDeSpawn = 3000
	const pantallaX = 23
	const pantallaY = 14
	const property enemigos = []
	const property jugador = new Jugador(image = "jugador1.png", 
							position = game.origin(), 
							sonidoDestroy = game.sound("death.wav"),
							tiempoDeathSound = 1000
							)
	
  	method iniciar(){
  		game.width(pantallaX)
  		game.height(pantallaY)
  		game.cellSize(50)
  		game.title("Juego")
  		game.boardGround("background.jpg")
  		game.addVisualCharacter(jugador)
  		self.anadirVidas()
  	
  		game.schedule(10, {musicaDeFondo.play()
  		musicaDeFondo.shouldLoop(true)})
  	
  		//COLISION CON ENEMIGOS
  		game.whenCollideDo(jugador, { elemento => 
    		game.say(jugador, "Auch")
    		
    		if(jugador.vida()==3){
    			vida3.image("heartGrey.png")
    		}
    		else if(jugador.vida()==2){
    			vida2.image("heartGrey.png")
    		}
    		else if(jugador.vida()==1){
    			vida1.image("heartGrey.png")
    		}
    		
    		jugador.vida(jugador.vida() - 1)
    		
    		if(jugador.vida() == 0){
    			jugador.destroy()
    		}
    		
    		enemigos.remove(elemento)
    		elemento.destroy()
  		})
  		
  		//DISPARAR
  	
  		keyboard.enter().onPressDo { jugador.disparar() } 
  		
  		//COLISION CON BALAS
  		game.onTick(100, "sprint", {
  									jugador.balas().forEach({b => b.colisionEnemigo()}) 
  									})
  		
  								
  		//SPAWNEAR ENEMIGOS
  		self.spawnearEnemigos()
  		//MOVER ENEMIGOS
  		game.onTick(500, "mover_enemigos", {self.moverEnemigos()}) 
  		//MOVER BALAS
  		game.onTick(100, "movers_balas", {self.moverBalas()})
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
  	
  	method anadirVidas(){
 	//Vida 1
  			game.addVisual(vida1)  	
	//Vida 2
  			game.addVisual(vida2)  		  	
	//Vida 3
  			game.addVisual(vida3)  			
  	}
  	method moverEnemigos(){
  		enemigos.forEach({e => e.moverse()})
  	}
  	method moverBalas(){
  		jugador.balas().forEach(	{b => b.moverse()
  							if(b.position().x() > pantallaX){jugador.balas().remove(b) game.removeVisual(b)}
  							}
  						)
  	}
}

//SONIDOS
const musicaDeFondo = game.sound("BackgroundSound.mp3")
//JUGADORES

//OBJETOS
 	//Vida 1
  			const vida1 = new Vida(position = game.at(0, 13), image = "heartRed.png")
	//Vida 2
  			const vida2 = new Vida(position = game.at(1, 13), image = "heartRed.png")
	//Vida 3
  			const vida3 = new Vida(position = game.at(2, 13), image = "heartRed.png")
