package entities {
	import Box2D.Common.Math.b2Vec2;
	import core.Entity;
	import core.Image;
	import core.ParticleEmitter;
	import entities.menu.Landing;

	public class MenuState extends GameState {
		private var landing:Landing;
		private var sparticlesRed:ParticleEmitter;
		private var sparticlesWhite:ParticleEmitter;
		
		public function MenuState() {
			
		}
		
		public function toggle(name:String) {
			landing.hide();
			
			if (this[name] != null) {
				(this[name] as GameState).hide();
			} else {
				throw new Error("Cannot set '" + name + "' to visible. Variable not found in Menustate.as");
			}
		}
		
		public override function init() : void {
			addChild(new Image("background"));
			
			addChild(sparticlesRed = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x990000, 2, -1, 10, 1, 0.015, 1000));
			addChild(sparticlesWhite = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x867777, 2, -1, 10, 1, 0.015, 1000));
			
			addChild(landing = new Landing());
			//addChild(new FrameCounter());
			
			
			//sparticlesRed.setPosition(getGame().windowSize);
			//sparticlesWhite.setPosition(getGame().windowSize);
			
			sparticlesRed.y = sparticlesWhite.y = getGame().windowSize.y;
		}

	}
}