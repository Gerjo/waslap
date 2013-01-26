package entities.menu {
	import core.Entity;
	import core.Image;
	import core.Time;
	import flash.display.Sprite;

	public class Beat extends Entity {
		private var masker:Sprite;
		private var image:Image;
		private var speed:Number = 5;
		private var magicNumber:Number = 333;
		private var animationSpeed = 0.01;
		private var _animationCounter = 0;
		
		public function Beat() {
			addChild(masker = new Sprite());
			
			
			masker.graphics.beginFill(0xffffff);
			masker.graphics.drawRect(0, 0, 333, 87);
			masker.graphics.endFill();
			
			mask = masker;
		}
		
		override public function init():void {
			super.init();
			
			addChild(image = new Image("static"));
		}
		
		override public function update(time:Time):void {
			super.update(time);
			
			// Only pulse uis animated.
			if (image.imageName == "static") {
				return;
			}
			
			_animationCounter += time.delta;
			
			if (_animationCounter > animationSpeed) {
				_animationCounter = 0;
				
				image.x -= speed;
			
				if (image.x < -1 * (image.width - magicNumber)) {
					image.x = -magicNumber;
				}
			}
		}
		
		public function showPulse() : void {
			image.x = 0;
			image.load("pulse");
		}
		
		public function showStatic() : void {
			image.x = 0;
			image.load("static");
		}
	}
}