package entities {
	import core.Entity;
	import core.Image;
	
	public class JumpLine extends Entity {
		private var _height:Number;
		
		public function JumpLine(height:Number) {
			_height = height;
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