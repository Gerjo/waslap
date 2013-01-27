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
	public class DifficultyState extends GameState {
		private var sparticlesRed:ParticleEmitter;
		private var sparticlesWhite:ParticleEmitter;
		
		private var beats:Array = new Array();
		private var fuses:Array = new Array();
		
		public function DifficultyState() {
		
		}
		
		override public function init():void {
			super.init();
			
			addChild(new Image("background"));
			var image:Image = new Image("logo");
			addChild(image);
			var moreOffsetX:Number = 30;
			var moreOffsetY:Number = -30;
			
			var offset:Number = 90 + moreOffsetY;
			var offsetFuse:Number = -142 + moreOffsetY;
			for (var i:int = 0; i < 3; ++i) {
				addChild(fuses[i] = new Image("fuse"));
				addChild(beats[i] = new Beat());
				
				beats[i].x = 50 + moreOffsetX;
				beats[i].y = offset += 102;
				
				fuses[i].x = 85 + moreOffsetX;
				fuses[i].y = offsetFuse += 102;
				fuses[i].visible = false;
			}
			
			var backButton:Button = new Button("backbutton", "backbuttonpressed", "", function():void {
					hide();
					getGame().menuState.landing.show();
				});
			
			backButton.x = 600;
			backButton.y = 520;
			addChild(backButton);
			
			var buttons:Array = [
					new Button("buttonhard", "buttonhardpressed", "", function():void {
					getGame().loadGameState("../src/assets/audio/175bpm_gameplay_HARD_master.wav");
				}, function () : void {
					beats[0].showPulse();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[0].visible = true;
				}, function () : void {
					beats[0].showStatic();
					fuses[0].visible = false;
				}), new Button("buttonnormal", "buttonnormalpressed", "", function():void {
					getGame().loadGameState("../src/assets/audio/barrywhite.mp3");
				}, function () : void {
					beats[0].showStatic();
					beats[1].showPulse();
					beats[2].showStatic();
					fuses[1].visible = true;
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[1].visible = false;
				}), new Button("buttoneasy", "buttoneasypressed", "", function():void {
					getGame().loadGameState("../src/assets/audio/airport.mp3");
				},function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showPulse();
					fuses[2].visible = true;
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[2].visible = false;
				})
				];
			var last:Button = buttons[0];
			addChild(last);
			last.y = 180;
			Button.AlignLeft(image, last);
			last.x -= 30;
			
			// Align others:
			for (var j:int = 1; j < buttons.length; ++j) {
				addChild(buttons[j]);
				Button.AlignUnder(last, buttons[j]);
				Button.AlignLeft(image, buttons[j]);
				last = buttons[j];
				last.x -= 30;
			}
			
			addChild(sparticlesRed = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x990000, 2, -1, 10, 1, 0.015, 1000));
			addChild(sparticlesWhite = new ParticleEmitter(new b2Vec2(1, -1), 100, 0x867777, 2, -1, 10, 1, 0.015, 1000));
			
			sparticlesRed.y = sparticlesWhite.y = getGame().windowSize.y;
		}
	
	}

}