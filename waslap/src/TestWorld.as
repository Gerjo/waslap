package {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TestWorld extends Sprite {
		public var worldScale:Number 	= 30;
		public var world:b2World		= new b2World(new b2Vec2(0, 10), true);
		
		public function TestWorld() {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event) {
			addCircle();
			debugDraw();
		}
		
		public function addCircle() : void {
			var myBody:b2BodyDef = new b2BodyDef();
			myBody.position.Set(stage.stageWidth / 2 / worldScale, stage.stageHeight / 2 / worldScale);
			myBody.type = b2Body.b2_dynamicBody;
			var myCircle:b2CircleShape = new b2CircleShape(10 / worldScale);
			var myFixture:b2FixtureDef = new b2FixtureDef();
			myFixture.shape = myCircle;
			myFixture.density = 1;
			myFixture.friction = 1;
			var body:b2Body = world.CreateBody(myBody);
			body.CreateFixture(myFixture);
		}
		
		public function debugDraw() : void {
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debugDraw);
		}
	
		public function update(e:Event) : void {
			trace("updating");
			world.Step(1 / 30, 10, 10);
			world.ClearForces();
			world.DrawDebugData();
		}
	}

}