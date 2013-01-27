package entities {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import datacontainer.Node;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import datacontainer.LinkedList;
	import core.*;
	
	public class Ground extends Entity {
		public var score:Number = 0;
		
		private var _isLoaded:Boolean = false;
		private var audio:ALF;
		private var nodes:Array = new Array();
		
		private var interval:Number       = 100; // offset between each "sample point"
		private var animationspeed:Number = 5;
		private var yCenterOffset:Number  = 100; // magic number.
		
		// box2d stuff
		private var bodyDef:b2BodyDef = new b2BodyDef();
		private var body:b2Body;
		private var polygon:b2PolygonShape = new b2PolygonShape();
		private var fixtureDef:b2FixtureDef = new b2FixtureDef();
		private var fixture:b2Fixture;
		
		public function Ground() {
			// first node, start with a flat line.
			nodes.push(new b2Vec2(0, getGame().halfWindowSize.y));
			nodes.push(new b2Vec2(getGame().windowSize.x, getGame().halfWindowSize.y));
			//nodes.push(new b2Vec2(getGame().windowSize.x + 10, getGame().halfWindowSize.y + 10));
			
			audio = new ALF("../src/assets/audio/menu128.wav", 0, 30, true, 0);
			audio.addEventListener(audio.FILE_LOADED, onFileLoad);
			
			bodyDef.type = b2Body.b2_staticBody;
			polygon.SetAsArray(nodes);
			
			fixtureDef.shape = polygon;
			
			body = getGame().getWorld().CreateBody(bodyDef);
			fixture = body.CreateFixture(fixtureDef);
		}
		
		private function onFileLoad(e:Event):void {
			audio.startAudio();
			_isLoaded = true;
			
			audio.addEventListener(audio.NEW_FRAME, onNewFrame);
		}
		
		private function onNewFrame(e:Event):void {
			if (_isLoaded) {
				var count:Number = nodes.length;
				
				if(nodes[count-1].x < getGame().windowSize.x) {
				
					var intensity:Number = audio.getIntensity();
					
					var node:b2Vec2 = new b2Vec2(
						// Last position plus interval. First node starts at zero.
						nodes[count - 1].x + interval,
						
						yCenterOffset + intensity / 20
					);
					
					nodes.push(node);
				}
				
				render();
				
				// Reload the vertices for the polygon:
				polygon.SetAsArray(nodes);
				body.DestroyFixture(fixture);
				fixture = body.CreateFixture(fixtureDef);
			}
		}
		
		public override function update(time:Time):void {
			super.update(time);
			
			for (var i:int = 0; i < nodes.length; ++i) {
				nodes[i].x -= animationspeed;
			}
		}
		
		public override function render():void {
			super.render();
			
			if (nodes.length == 0) {
				return;
			}
			
			graphics.clear();
			graphics.lineStyle(1, 0xffff00);
			graphics.moveTo(nodes[0].x, nodes[0].y);
			
			for (var i:int = 1; i < nodes.length; ++i) {
				graphics.lineTo(nodes[i].x, nodes[i].y);
			}
			
			graphics.endFill();
		}
	}
}
