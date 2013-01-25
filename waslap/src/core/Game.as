package core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import entities.*;
	import Box2D.Common.Math.b2Vec2;
	
	public class Game extends Entity {
		public static var instance:Game; // hack hack hack!
		public var windowSize:b2Vec2     = new b2Vec2(800, 600);
		public var halfWindowSize:b2Vec2 = new b2Vec2(windowSize.x * 0.5, windowSize.y * 0.5);
		
		private var _fps:int         = 60;
		private var _time:Time       = new Time(1 / _fps);
		
		public function Game() {
			instance = this;
			// NB: don't do stuff here, use init().
			
			trace("The game is loaded and works - Thomas Jefferson (1820)");
			trace(" - actually, that is an assumption - Winston Churchill (1946)");
		}
		
		public function init() : void {
			stage.frameRate = _fps;
			
			addChild(new Player());
		}
		
		public function enterFrame(event:Event) : void {
			this.update(_time);
		}
		
		public override function update(time:Time) : void {
			super.update(time);
		}
	}
}