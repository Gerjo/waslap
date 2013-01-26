package entities {
	import core.Entity;
	import core.Time;

	public class FrameCounter extends Entity {
		private var lastStamp:Number = new Date().time;
		private var frames:int   	 = 0;
		private var framesBuffer:int = 0;
		private var lastFrame:Number = 0;
		private var text:Text        = new Text();
		
		public function FrameCounter() {
			addChild(text);
		}
		
		public override function update(time:Time):void {
			super.update(time);
			
			frames++;
			
			if (new Date().time - lastStamp > 1000) {
				framesBuffer = frames;
				lastStamp    = new Date().time;
				frames       = 0;
				
				text.setText('Frames per second: ' + framesBuffer + "/" + stage.frameRate + " (" + (new Date().time-lastFrame) + " ms per frame)");
			}
			
			lastFrame = new Date().time;
		}
	}
}