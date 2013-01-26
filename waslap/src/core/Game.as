package core
{
	import flash.display.Bitmap;
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
		private var _players:Array   = new Array();
		
		private var _background:Layer = new Layer();
		private var _entities:Layer   = new Layer();
		private var _particles:Layer  = new Layer();
		private var _gui:Layer        = new Layer();
		
		public function Game() {
			instance = this;
			// NB: don't do stuff here, use init().
		}
		
		public function init() : void {
			stage.frameRate = _fps;
			
			addChild(_background);
			addChild(_entities);
			addChild(_particles);
			addChild(_gui);
			
			_players.push(new Player().setPosition(30, 33.141592));
			_players.push(new Player());
			_entities.addChild(_players[0]);
			_entities.addChild(_players[1]);
			
			
			_background.addChild(new Image("test").center());
			
			_entities.addChild(new Ground());
			
			
			//Audio.play("airport", 1);
		}
		
		public function enterFrame(event:Event) : void {
			this.update(_time);
		}
		
		public override function update(time:Time) : void {
			super.update(time);
			
			if (_players[0].getBox().Contains(_players[1].getBox())) {
				//("Yay");
			} else {
				//trace("Nay");
			}
		}
	}
}