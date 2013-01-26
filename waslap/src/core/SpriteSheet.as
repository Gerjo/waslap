package core  {
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	
	public class SpriteSheet extends Entity {
		private var image:Image;
		private var clipping:b2Vec2;
		private var masker:Sprite;
		
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
			
			image.x -= clipping.x;
			
			trace(image.x, -image.width);
			
			if (image.x < -1 * (image.width - clipping.x)) {
				image.x = 0;
			}
			
		}
	}
}