package entities 
{
	import core.Entity;
	import core.Message;
	import core.Time;

	public class Player extends Entity {
		public function Player() {
		}
		
		override public function render():void {
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 10);
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
			trace("TODO: Flipping");
		}
	}
}