package entities.menu {
	import entities.GameState;
	/**
	 * ...
	 * @author Nico Glas
	 */
	public class Credits extends GameState {
		
		public function Credits() {
			
		}
		
		override public function init():void {
			super.init();
			
			addChild(new Image("background"));
			
			addChild(sparticlesRed = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x990000, 2, -1, 10, 1, 0.015, 1000));
			addChild(sparticlesWhite = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x867777, 2, -1, 10, 1, 0.015, 1000));
			
			sparticlesRed.y = sparticlesWhite.y = getGame().windowSize.y;
		}
		
	}

}