package entities 
{
	import core.Entity;
	import core.Time;

	public class Player extends Entity {
		public function Player() {
			render();
		}
		
		override public function render():void {
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		
		override public function update(time:Time):void {
			super.update(time);
			trace("I'm a player");
		}
	}
}