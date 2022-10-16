import wollok.game.*
class Character {
	var property position
	var property image
	var sonidoDestroy
	const tiempoDeathSound
	
	method destroy() {
		sonidoDestroy.play()
		game.schedule(tiempoDeathSound,{sonidoDestroy.stop()}) //Para que pare el sonido
		game.removeVisual(self)
	}
}
