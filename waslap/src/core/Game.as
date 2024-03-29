package core {
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import entities.*;
	import Box2D.Common.Math.b2Vec2;
	import flash.text.TextField;
	
	public class Game extends Entity {
		public static var instance:Game; // hack hack hack!
		public var windowSize:b2Vec2 = new b2Vec2(800, 600);
		public var halfWindowSize:b2Vec2 = new b2Vec2(windowSize.x * 0.5, windowSize.y * 0.5);
		
		public var soundLine:Ground;
		
		public var _fps:int = 60;
		private var _time:Time = new Time(1 / _fps);
		private var _player:Player;
		public var _jumpLines:Array;
		public var _ground:Ground;
		private var _background:Layer = new Layer();
		private var _entities:Layer = new Layer();
		private var _particles:Layer = new Layer();
		private var _gui:Layer = new Layer();
		private var _score:TextField;
		private var input:Input;
		private var _world:b2World = new b2World(new b2Vec2(0, 100), false);
		private var isLoaded:Boolean = false;
		public var gameState:GameState;
		public var menuState:MenuState;
		
		public function Game() {
			instance = this;
		}
		
		public function loadGameState(sound:String):void {
			if (!isLoaded) {
				addChild(gameState = new GameState());
				gameState.addChild(_background);
				gameState.addChild(_entities);
				gameState.addChild(_particles);
				gameState.addChild(_gui);
				
				var input:Input = new Input();
				addChild(input);
				input.init();
				_score = new TextField();
				_score.x = 710;
				_score.y = 10;
				
				_particles.addChild(new ParticleEmitter(new b2Vec2(1, 1), 10, 0xffffff, 0.3));
				_background.addChild(new Image("background"));
				_entities.addChild(_ground = new Ground(sound));
				//_gui.addChild(new FrameCounter());
				_gui.addChild(_score);
				_jumpLines = [new JumpLine(100, true), new JumpLine(500, false)];
				
				for each (var j:JumpLine in _jumpLines)
					_gui.addChild(j);
				
				// Le player, because that's not obvious, ehhh?
				_entities.addChild(_player = new Player());
				
				debugDraw();
				isLoaded = true;
				menuState.hide();
				
				// NB: don't do stuff here, use init().
				var a:Sprite = new Sprite();
				a.graphics.beginFill(0xFFFFFF);
				a.graphics.drawRect(0, 0, 800, 600);
				a.graphics.endFill();
				gameState.addChild(a);
				gameState.mask = a;
				
				gameState.show();
			}
		}
		
		public override function init():void {
			stage.frameRate = _fps;
			stage.focus = this;
			
			addChild(menuState = new MenuState());
		}
		
		public function enterFrame(event:Event):void {
			this.update(_time);
		}
		
		public function debugDraw():void {
			return;
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(1);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			_world.SetDebugDraw(debugDraw);
		}
		
		public function gameover():void {
			trace("You're game over.");
			gameState.hide();
			resetEverythingBackToDefaultsAndYesIKnowThisIsALongFunctionNameSomePeopleEnjoyCodeCompletion();
			
			menuState.show();
		
			//TODO: Some bloody message box bugging you about your highscore.
		}
		
		public function resetEverythingBackToDefaultsAndYesIKnowThisIsALongFunctionNameSomePeopleEnjoyCodeCompletion():void {
			//removeChild(gameState);
			//removeChild(input);
			//_gui.removeChild(_score);
		}
		
		public override function update(time:Time):void {
			super.update(time);
			if (isLoaded) {
				_score.text = "score = " + _ground.score;
				
				_world.Step(1 / _fps, 2, 4);
				_world.ClearForces();
				_world.DrawDebugData();
			}
		}
		
		public function getWorld():b2World {
			return _world;
		}
		
		public function getPlayer():Player {
			return _player;
		}
	}
}