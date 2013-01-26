package core  {
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	
	public class SpriteSheet extends Entity {
		private var image:Image;
		private var clipping:b2Vec2;
		private var masker:Sprite;
		private var _deltaCounter:Number = 0;
		
		// Default speed:
		private var _speed:Number = 0.02;
		
		public function SpriteSheet(name:String, width:Number, height:Number) {
			addChild(image = new Image(name));
			clipping = new b2Vec2(width, height);
			
			addChild(masker = new Sprite());
			masker.graphics.beginFill(0x000000);
			masker.graphics.drawRect(0, 0, width, height);
			masker.graphics.endFill();
			
			mask = masker;
		}
		
		public override function update(time:Time):void {
			super.update(time);
			
			_deltaCounter += time.delta;
			
			// Accumulate deltas until the threshold is reached.
			if (_deltaCounter > _speed) {
				image.x -= clipping.x;
			
				if (image.x < -1 * (image.width - clipping.x)) {
					image.x = 0;
				}
				
				_deltaCounter = 0;
			}
		}
		
		private function setSpeed(speed:Number) : void {
			_speed = speed;
		}
	}
}