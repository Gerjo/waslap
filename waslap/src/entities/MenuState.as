package entities {
	import Box2D.Common.Math.b2Vec2;
	import core.Entity;
	import core.Image;
	import core.ParticleEmitter;
	import entities.menu.ControlScreen;
	import entities.menu.Credits;
	import entities.menu.DifficultyState;
	import entities.menu.Landing;

	public class MenuState extends GameState {
		public var landing:Landing;
		public var control:ControlScreen;
		public var credits:Credits;
		public var difficulty:DifficultyState;
		private var sparticlesRed:ParticleEmitter;
		private var sparticlesWhite:ParticleEmitter;
		
		public function MenuState() {
			
		}
		
		public function toggle(name:String):void {
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
			addChild(control = new ControlScreen());
			addChild(credits = new Credits());
			addChild(difficulty = new DifficultyState());
			difficulty.hide();
			credits.hide();
			control.hide();
			
			//addChild(new FrameCounter());
			
			
			//sparticlesRed.setPosition(getGame().windowSize);
			//sparticlesWhite.setPosition(getGame().windowSize);
			
			sparticlesRed.y = sparticlesWhite.y = getGame().windowSize.y;
		}

	}
}