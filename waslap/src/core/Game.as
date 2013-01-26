package core
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import entities.*;
	import Box2D.Common.Math.b2Vec2;
	import flash.text.TextField;
		
	public class Game extends Entity {
		public static var instance:Game; // hack hack hack!
		public var windowSize:b2Vec2     = new b2Vec2(800, 600);
		public var halfWindowSize:b2Vec2 = new b2Vec2(windowSize.x * 0.5, windowSize.y * 0.5);
		
		private var _fps:int         = 60;
		private var _time:Time       = new Time(1 / _fps);
		private var _player:Player   = new Player();
		private var _ground:Ground	 = new Ground();
		private var _background:Layer = new Layer();
		private var _entities:Layer   = new Layer();
		private var _particles:Layer  = new Layer();
		private var _gui:Layer        = new Layer();
		private var _score:TextField;
		public function Game() {
			instance = this;
			// NB: don't do stuff here, use init().
		}
		
		public function init() : void {
			stage.frameRate = _fps;
			stage.focus = this;
			var input:Input = new Input();
			addChild(input);
			input.init();
			
			addChild(_background);
			addChild(_entities);
			addChild(_particles);
			addChild(_gui);
			_score = new TextField();
			_score.x = 710;
			_score.y = 10;
			_gui.addChild(_score);
			_entities.addChild(_player);
			_player.setPosition(30, halfWindowSize.y);
			
			_background.addChild(new Image("test").center());
			
			_entities.addChild(_ground);
			
			
			//Audio.play("airport", 1);
		}
		
		public function enterFrame(event:Event) : void {
			this.update(_time);
		}
		
		public override function update(time:Time) : void {
			super.update(time);
			_score.text = "score = " +_ground.score;
		}
	}
}