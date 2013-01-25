package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite {
		public function Game() {
			trace("The game is loaded and works.");
			trace(" - actually, that is an assumption.");
		}
		
		public function update(event:Event) : void {
			trace("Update...");
		}
	}
}