package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite implements IUpdatable {
		public static var instance:Game; // hack hack hack!
		private var _time:Time = new Time(0.16666666667);
		
		public function Game() {
			instance = this;
			stage.frameRate = 60;
			trace("The game is loaded and works.");
			trace(" - actually, that is an assumption.");
		}
		
		public function update(event:Event) : void {
			
			for (var i:int = 0; i < numChildren; ++i) {
				(getChildAt(i) as IUpdatable).update(_time);
			}
			
			trace("Update...");
		}
	}
}