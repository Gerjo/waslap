package entities.menu {
	import Box2D.Common.Math.b2Vec2;
	import core.Image;
	import core.ParticleEmitter;
	import core.Time;
	import entities.Button;
	import entities.GameState;
	
	/**
	 * ...
	 * @author Nico Glas
	 */
	public class Credits extends GameState {
		private var sparticlesRed:ParticleEmitter;
		private var sparticlesWhite:ParticleEmitter;
		
		public function Credits() {
		
		}
		
		override public function update(time:Time):void {
			super.update(time);
		
		}
		
		override public function init():void {
			super.init();
			
			addChild(new Image("background"));
			
			addChild(sparticlesRed = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x990000, 2, -1, 10, 1, 0.015, 1000));
			addChild(sparticlesWhite = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x867777, 2, -1, 10, 1, 0.015, 1000));
			
			sparticlesRed.y = sparticlesWhite.y = getGame().windowSize.y;
			var backButton:Button = new Button("backbutton", "backbuttonpressed", "", function():void {
					hide();
					getGame().menuState.landing.show();
				});
			backButton.x = 600;
			backButton.y = 520;
			addChild(backButton);
		}
	
	}

}