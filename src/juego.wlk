import wollok.game.*
import Jugador.*
import Enemigo.*
import Character.*
import Vida.*

object juego{
	var property tiempoDeSpawn = 3000
	const property pantallaX = 23
	const property pantallaY = 14
	const property enemigos = []
	const property jugador = new Jugador(image = "jugador1.png", 
							position = game.origin(), 
							sonidoDestroy = game.sound("death.wav"),
							tiempoDeathSound = 1000
							)
	const musicaDeFondo = game.sound("BackgroundSound.mp3")

  	const property vida1 = new Vida(position = game.at(0, 13), image = "heartRed.png")
  	const property vida2 = new Vida(position = game.at(1, 13), image = "heartRed.png")
  	const property vida3 = new Vida(position = game.at(2, 13), image = "heartRed.png")
	
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
  		game.whenCollideDo(jugador, { elemento =>  elemento.colisionJugador() })
  		//DISPARAR
  		keyboard.enter().onPressDo { jugador.disparar() } 
  		//COLISION CON BALAS - REVISAR	
  		game.onTick(100, "sprint", { jugador.balas().forEach({b => b.colisionEnemigo()}) })			
  		//MOVER ENEMIGOS
  		game.onTick(500, "mover_enemigos", {self.moverEnemigos()}) 
  		//MOVER BALAS
  		game.onTick(100, "movers_balas", {self.moverBalas()})
  		//SPRINTS
  		self.gestionarSprints()
  		//AUMENTAR DIFICULTAD
  		game.onTick(1000, "aumentar_dificultad", {self.aumentarDificultad()} )
  		//SPAWNEAR ENEMIGOS
  		self.spawnearEnemigos(tiempoDeSpawn)
  	}
  
  	method spawnearEnemigos(tiempo){
  		game.onTick(tiempo, "crearEnemigo", {
  			const enemigo = new Enemigo(image = "enemigo1.png", 
  										position = game.at(pantallaX - 1, 0.randomUpTo(pantallaY)), 
  										irAbajo = 1.randomUpTo(0),
  										sonidoDestroy = game.sound("alienDeath.wav"),
  										tiempoDeathSound = 300,
  										vida = 1
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
  		jugador.balas().forEach( {b => b.moverse() })
  	}
  	method gestionarSprints(){
  		//SPRINT ENEMIGOS
  		enemigos.forEach({e => e.cambiarImagen()})
  		game.onTick(800, "sprint", {enemigos.forEach({e => e.cambiarImagen()})})
  		//SPRINT JUGADOR
  		jugador.cambiarImagen()
  		game.onTick(300, "sprint", {jugador.cambiarImagen()})
  	}
  	method aumentarDificultad(){
  		if(tiempoDeSpawn > 500){
  			tiempoDeSpawn -= 100	
  		}
  	}
}


