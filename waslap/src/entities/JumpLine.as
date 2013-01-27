package entities {
	import core.Entity;
	import core.Image;
	
	public class JumpLine extends Entity {
		private var _height:Number;
		private var _upIsDead:Boolean;
		
		public function JumpLine(height:Number, upIsDead:Boolean = true) {
			_height = height;
			_upIsDead = upIsDead;
		}
		
		public function getHeight() : Number {
			return _height;
		}
		public function upIsDead() : Boolean {
			return _upIsDead;
		}
		
		override public function render():void 
		{
			super.render();
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawRect(0, _height, stage.stageWidth, 3);
			graphics.endFill();
		}
	}

}