import wollok.game.*
import Jugador.*
import Enemigo.*
import Character.*
import Bala.*

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
	const musicaGameOver = game.sound("gameOver.mp3")

  	const property vida1 = new Imprimible(position = game.at(0, 13), image = "heartRed.png")
  	const property vida2 = new Imprimible(position = game.at(1, 13), image = "heartRed.png")
  	const property vida3 = new Imprimible(position = game.at(2, 13), image = "heartRed.png")
	const property armaActual = new Imprimible(position = game.at(0, 12), image = jugador.armaActual().icon())
	const gameOver = new Imprimible(position = game.at(9, 8), image = "gameOver.png")
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
  		game.onTick(100, "sprint", { jugador.balas().forEach({b => 
  															game.whenCollideDo(b, { objeto => 
    								  						objeto.colisionBala(b)}) }) })			
  		//MOVER ENEMIGOS
  		game.onTick(500, "mover_enemigos", {self.moverEnemigos()}) 
  		//MOVER BALAS
  		game.onTick(100, "mover_balas", {self.moverBalas()})
  		//SPRINTS
  		self.gestionarSprints()
  		//AUMENTAR DIFICULTAD - REVISAR
  		//game.onTick(1000, "aumentar_dificultad", {self.aumentarDificultad()} )
  		//SPAWNEAR ENEMIGOS
  		self.spawnearEnemigos(tiempoDeSpawn)
  		
  		//CAMBIO DE ARMAS
  		keyboard.num1().onPressDo { 
  			self.cambiarArma(bala)
  		} 
  		 keyboard.num2().onPressDo { 
  		self.cambiarArma(bomba)
  		} 
  		 keyboard.num3().onPressDo { 
  		self.cambiarArma(misil)
  		}   	
  		}
  
  	method cambiarArma(armaNueva){
  		jugador.cambiarArma(armaNueva)
  			armaActual.image(armaNueva.icon())
  	}
  
  	method spawnearEnemigos(tiempo){
  		game.onTick(tiempo, "crearAlien", {
  			const alien = self.crearAlien()
  			game.addVisual(alien)
  			enemigos.add(alien)										
  		})
  		game.onTick(tiempo + 3000 , "crearUfo", {
  			const ufo = self.crearUfo()
  			game.addVisual(ufo)
  			enemigos.add(ufo)										
  		})
  		game.onTick(tiempo + 5000 , "crearNaveX", {
  			const nave = self.crearNaveX()
  			game.addVisual(nave)
  			enemigos.add(nave)										
  		})
  	}
  	
  	method anadirVidas(){
 	//Vida 1
  			self.imprimir(vida1)  	
	//Vida 2
  			self.imprimir(vida2)  		  	
	//Vida 3
  			self.imprimir(vida3)  		
  	//ARMA ACTUAL (NO VA ACA)
  			self.imprimir(armaActual)  	
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
  	
  	method gameOver(){
  		musicaDeFondo.stop()
  		musicaGameOver.play()
  		game.schedule(1000, {self.imprimir(gameOver)})
  		
  		
  	}
  	method imprimir(algo){
  		game.addVisual(algo)
  	}
  	method crearAlien(){
  		return new Alien(  image = "enemigo1.png", 
  										position = game.at(pantallaX - 1, 0.randomUpTo(pantallaY)), 
  										irAbajo = 1.randomUpTo(0),
  										sonidoDestroy = game.sound("alienDeath.wav"),
  										tiempoDeathSound = 300,
  										vida = 1
  									  )
  	}
  	method crearUfo(){
  		return new Ufo(  image = "U1.png", 
  										position = game.at(pantallaX - 1, 5), 
  										sonidoDestroy = game.sound("alienDeath.wav"),
  										tiempoDeathSound = 300,
  										vida = 2
  									  )
  	}
  	method crearNaveX(){
  		return new NaveX(  image = "B1.png", 
  										//position = game.at(pantallaX - 1, 0.randomUpTo(pantallaY)), 
  										position = game.at(0.randomUpTo(pantallaX), pantallaY - 1),
  										sonidoDestroy = game.sound("alienDeath.wav"),
  										tiempoDeathSound = 300,
  										vida = 3
  									  )
  	}
}


