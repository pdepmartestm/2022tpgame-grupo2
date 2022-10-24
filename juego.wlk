import wollok.game.*
import Jugador.*
import Enemigo.*
import Character.*
import Bala.*

object juego{
	var property tiempoDeSpawn = 3000
	const property pantallaX = 24
	const property pantallaY = 14
	const property enemigos = []
	const property jugador = new Jugador(image = "jugador1.png", 
							position = game.at(0,7), 
							sonidoDestroy = game.sound("death.wav"),
							tiempoDeathSound = 1000
							)
	const property musicaDeFondo = game.sound("BackgroundSound.mp3")
	const musicaGameOver = game.sound("gameOver.mp3")
	const property fondo = new Imprimible(image = "background.jpg", position = game.at(0,0))
	
  	const property vida1 = new Vida(position = game.at(0, 13))
  	const property vida2 = new Vida(position = game.at(1, 13))
  	const property vida3 = new Vida(position = game.at(2, 13))
  	
	const property armaActual = new Imprimible(position = game.at(0, 12), image = jugador.armaActual().icon())
	const gameOver = new Imprimible(position = game.at(10, 6), image = "gameOver.png")
  	method iniciar(){
  		game.width(pantallaX)
  		game.height(pantallaY)
  		game.cellSize(50)
  		game.title("Juego")
  		
  		game.boardGround("background.jpg")
  	
  		
  		//MOVER ENEMIGOS
  		game.onTick(500, "mover_enemigos", {self.moverEnemigos()}) 
  		//MOVER BALAS
  		game.onTick(100, "movers_balas", {self.moverBalas()})
  		//SPRINTS
  		self.gestionarSprints()
  		//INICIAR
  		game.schedule(10,{menu.correrRutina()})	
  	}
  	
  	method anadirVidas(){
  			self.imprimir(vida1)  	
  			self.imprimir(vida2) 
  			self.imprimir(vida3)  		
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
  	}
  	
  	method game_Over(){
  		musicaDeFondo.stop()
  		musicaGameOver.play()
  		game.schedule(500, {self.imprimir(gameOver)})
  		game.schedule(5500, {game.stop()})
  	}
  	method imprimir(algo){
  		game.addVisual(algo)
  	}
  	method manejarJugador(){
  		//COLISION CON ENEMIGOS
  		game.whenCollideDo(jugador, { elemento =>  elemento.colisionJugador() })
  		//DISPARAR
  		keyboard.space().onPressDo { jugador.disparar() } 
  		//COLISION CON BALAS - REVISAR
  		game.onTick(100, "sprint", { jugador.balas().forEach({b => 
  															game.whenCollideDo(b, { objeto => 
    								  						objeto.colisionBala(b)}) }) })	
    	//CAMBIO DE ARMAS
  		keyboard.num1().onPressDo { 
  			jugador.cambiarArma(bala)
  			armaActual.image("balaIcon.png")
  		} 
  		 keyboard.num2().onPressDo { 
  			jugador.cambiarArma(bomba)
  			armaActual.image("bombaIcon.png")
  		} 
  		 keyboard.num3().onPressDo { 
  			jugador.cambiarArma(misil)
  			armaActual.image("misilIcon.png")
  		}   	
    	
  	}
}

class Nivel{
	const missionComplete = game.sound("missionComplete.wav")
	const duracion = 50000
	method spawnearAliens(tiempo){
		game.onTick(tiempo, "crearAlien", {
  			const alien = new Alien(irAbajo = 0.randomUpTo(1))
  			game.addVisual(alien)
  			juego.enemigos().add(alien)								
  		})
	}
	method spawnearUfos(tiempo){
		game.onTick(tiempo , "crearUfo", {
  			const ufo = self.crearUfo()
  			game.addVisual(ufo)
  			juego.enemigos().add(ufo)								
  		})
	}
	method spawnearNavesX(tiempo){
		game.onTick(tiempo , "crearNaveX", {
  			const nave = self.crearNaveX()
  			game.addVisual(nave)
  			juego.enemigos().add(nave)								
  		})
	}
	method crearAlien(){
		return new Alien(irAbajo = 0.randomUpTo(1))
	}
	method crearUfo(){
		return new Enemigo (image = "U1.png",  tiempoDeathSound = 300, vida = 1, tipoMovimiento = movimientoRectilineoIzquierdo, cantSprint = 6, SprintHint = "U");
	}
	method crearNaveX(){
		return new Enemigo ( image = "B1.png", tiempoDeathSound = 300, vida = 3, tipoMovimiento = movimientoDirigido, cantSprint = 10, SprintHint = "B");
	}
}
object nivel1 inherits Nivel{
	const inicio = new Imprimible(image = "nivel1Start.png", position = game.at(10, 6))
	const final = new Imprimible(image = "nivel1End.png", position = game.at(10, 6))
	const mission1Start = game.sound("missionOnestart.wav")
	
	method correrRutina(){
		game.addVisual(inicio)
		mission1Start.play()
		game.schedule(5000, {game.removeVisual(inicio)
							mission1Start.stop()
							self.spawnearUfos(1000)
		})
		game.schedule(duracion, {self.finalizar()})
	}
	method finalizar(){
		game.removeTickEvent("crearUfo")
		juego.enemigos().forEach({e => e.destroy()})
		game.addVisual(final)
		missionComplete.play()
		game.schedule(6000, {missionComplete.stop() game.removeVisual(final)})
		game.schedule(6100, {nivel2.correrRutina()})
	}
}
object nivel2 inherits Nivel{
	const inicio = new Imprimible(image = "nivel2Start.png", position = game.at(10, 6))
	const final = new Imprimible(image = "nivel2End.png", position = game.at(10, 6))
	const mission2Start = game.sound("missionTwostart.wav")
	method correrRutina(){
		game.addVisual(inicio)
		mission2Start.play()
		game.schedule(5000, {game.removeVisual(inicio)
							mission2Start.stop()
							self.spawnearAliens(2000)
		})
		game.schedule(duracion, {self.finalizar()})
	}
	method finalizar(){
		game.removeTickEvent("crearAlien")
		juego.enemigos().forEach({e => e.destroy()})
		game.addVisual(final)
		missionComplete.play()
		game.schedule(6000, {missionComplete.stop() game.removeVisual(final)})
		game.schedule(6100, {nivel3.correrRutina()})
	}
}
object nivel3 inherits Nivel{
	const inicio = new Imprimible(image = "nivel3Start.png", position = game.at(10, 6))
	const final = new Imprimible(image = "nivel3End.png", position = game.at(10, 6))
	const mission3Start = game.sound("missionThreestart.wav")
	method correrRutina(){
		game.addVisual(inicio)
		mission3Start.play()
		game.schedule(5000, {game.removeVisual(inicio)
							mission3Start.stop()
							self.spawnearNavesX(2000)
		})
		game.schedule(duracion, {self.finalizar()})
	}
	method finalizar(){
		game.removeTickEvent("crearNaveX")
		juego.enemigos().forEach({e => e.destroy()})
		game.addVisual(final)
		missionComplete.play()
		game.schedule(6000, {missionComplete.stop() game.removeVisual(final)})
		game.schedule(6100,{game.stop()})
	}
}
object menu {
	const menuMusic = game.sound("intro.mp3")
	const property menuImagen = new Imprimible(image = "menu.jpg", position = game.at(0,0))
	const property pressStart = new Imprimible(image = "pressStart.png", position = game.at(6,0))
	var trigger
	method correrRutina(){
		trigger =  true
		game.addVisual(menuImagen)
		self.efectoLetrero(pressStart)
		menuMusic.play()
		menuMusic.shouldLoop(true)
		keyboard.enter().onPressDo {self.finalizar()}
			
	}
	method finalizar(){
		if(trigger){
			menuMusic.stop()
			game.removeVisual(menuImagen)
			self.eliminarEfectoLetrero(pressStart)
			juego.musicaDeFondo().play()
			juego.musicaDeFondo().shouldLoop(true)
			game.addVisualCharacter(juego.jugador())
	  		juego.anadirVidas()
	  		juego.manejarJugador()
			nivel1.correrRutina()
		}
		trigger = false
	}
	method efectoLetrero(imagen){
		game.addVisual(imagen)
		game.schedule(500,{game.removeVisual(imagen)})
		game.onTick(1000, "parpadear_"+imagen.image(), {  
			game.addVisual(imagen)
			game.schedule(500,{game.removeVisual(imagen)})
		})
	}
	method eliminarEfectoLetrero(imagen){
		game.removeTickEvent("parpadear_"+imagen.image())
	}
}