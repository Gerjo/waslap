package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import core.*;
	import ALF;
	
	public class Main extends Sprite {
		private var _game:Game;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_game = new Game());
			_game.init();
			
			addEventListener(Event.ENTER_FRAME, _game.enterFrame);
		}
	}
}