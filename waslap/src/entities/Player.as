package entities 
{
	import core.Entity;
	import core.Message;
	import core.Time;

	public class Player extends Entity {
		private var _isFlipped:Boolean = false;
		
		public function Player() {
		}
		
		override public function render():void {
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 10);
			graphics.drawCircle(0, 10, 3);
			graphics.endFill();
		}
		
		override public function update(time:Time):void {
			super.update(time);
			//trace("I'm a player");
		}
		
		override public function handleMessage(msg:Message):void {
			super.handleMessage(msg);
			
			if (msg.type == "KeyboardEvent" && msg.payload == "jump") {
				jump();
			}
			else if (msg.type == "KeyboardEvent" && msg.payload == "flip") {
				flip();
			}
		}
		
		public function jump() : void {
			trace("TODO: Jumping");
		}
		
		public function flip() : void {
			if (!_isFlipped) {
				this.y -= this.height;
				this.scaleY *= -1;
			} else {
				this.y += this.height;
				this.scaleY *= -1;
			}
			
			_isFlipped = _isFlipped ? false : true;
		}
	}
}