package core
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
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
		
		public var soundLine:Ground;
		
		private var _fps:int          = 60;
		private var _time:Time        = new Time(1 / _fps);
		private var _player:Player;
		public var _ground:Ground;
		private var _background:Layer = new Layer();
		private var _entities:Layer   = new Layer();
		private var _particles:Layer  = new Layer();
		private var _gui:Layer        = new Layer();
		private var _score:TextField;
		
		private var _world:b2World    = new b2World(new b2Vec2(0, 100), false);
		
		private var gameState:GameState;
		private var menuState:GameState;
		
		public function Game() {
			instance 		= this;
			// NB: don't do stuff here, use init().
		}
		
		private function loadGameState() : void {
			addChild(gameState = new GameState());
			gameState.addChild(_background);
			gameState.addChild(_entities);
			gameState.addChild(_particles);
			gameState.addChild(_gui);
			
			var input:Input = new Input();
			addChild(input);
			input.init();
			_score   = new TextField();
			_score.x = 710;
			_score.y = 10;
			
			_particles.addChild(new ParticleEmitter(new b2Vec2(1,1), 10, 0xffffff, 0.3));
			_background.addChild(new Image("background"));
			_entities.addChild(_ground = new Ground());
			_gui.addChild(new FrameCounter());
			_gui.addChild(_score);
			_gui.addChild(new JumpLine(200));
			_gui.addChild(new JumpLine(400));
			
			// bunch of hardcoded lines. TODO: link this to alf.
			var start:b2Vec2 = new b2Vec2(0, 0);
			for (var i:int = 0; i < 100; ++i) {
				var end:b2Vec2 = new b2Vec2(i * 45, Math.random() * 100);
				_gui.addChild(new LineSegment(start.x, start.y, end.x, end.y));
				start = end;
			}
			
			// Le player, because that's not obvious, ehhh?
			_entities.addChild(_player = new Player());
			
			debugDraw();
		}
		
		private function loadMenuState() : void {
			addChild(menuState = new GameState());
			menuState.addChild(new Image("background"));
			menuState.addChild(new FrameCounter());
			
			var buttons:Array = [
				new Button("playbutton", "playbuttonpressed", "", function () : void {
					menuState.hide();
					gameState.show();
				}),
				
				new Button("controlsbutton", "controlsbuttonpressed", "", function () : void {
					trace("controlsbutton");
				}),
				
				new Button("creditsbutton", "creditsbuttonpressed", "",  function () : void {
					trace("creditsbutton");
				})
			];
			
			// Top button:
			var last:Button = buttons[0];
			menuState.addChild(last);
			last.x = (windowSize.x - last.width) * 0.5;
			last.y = 100;
			
			// Align others:
			for (var i:int = 1; i < buttons.length; ++i) {
				menuState.addChild(buttons[i]);
				Button.AlignUnder(last, buttons[i]);
				last = buttons[i];
			}
		}
		
		public function init() : void {
			stage.frameRate = _fps;
			stage.focus 	= this;
			
			
			loadGameState();
			loadMenuState();
		}
		
		public function enterFrame(event:Event) : void {
			this.update(_time);
		}
		
		public function debugDraw() : void {
			return; // Enable for debug stuff.
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(1);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			_world.SetDebugDraw(debugDraw);
		}
		
		public override function update(time:Time) : void {
			super.update(time);
			_score.text = "score = " + _ground.score;

			_world.Step(1 / _fps, 2, 4);
			_world.ClearForces();
			_world.DrawDebugData();
		}
		
		public function getWorld() : b2World {
			return _world;
		}
		
		public function getPlayer() : Player {
			return _player;
		}
	}
}