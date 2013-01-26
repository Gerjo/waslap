package {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TestWorld extends Sprite {
		public var worldScale:Number 	= 30;
		public var world:b2World		= new b2World(new b2Vec2(0, 10), true);
		public var bodyList:Array		= new Array();
		
		public function TestWorld() {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event) : void {
			addRect();
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
			bodyList.push(body);
		}
		
		public function addRect() : void {
			var myBody:b2BodyDef = new b2BodyDef();
			myBody.position.Set(0 / worldScale, 500 / worldScale);
			myBody.type = b2Body.b2_staticBody;
			
			var myCircle:b2PolygonShape = new b2PolygonShape();
			myCircle.SetAsBox(800 / worldScale, 100 / worldScale);
			
			var myFixture:b2FixtureDef = new b2FixtureDef();
			myFixture.shape = myCircle;
			myFixture.density = 1;
			myFixture.friction = 0;
			var body:b2Body = world.CreateBody(myBody);
			body.CreateFixture(myFixture);
			bodyList.push(body);
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
	
		static var gravc:int = 0;
		public function update(e:Event) : void {
			gravc++
			if (gravc > 500) {
				gravc = 0;
				trace("Switched grav");
				world.SetGravity(new b2Vec2(0, -10));
				for (var i:uint = 0; i < bodyList.length; ++i) {
					bodyList[i].SetAwake(true);
				}
			}
			world.Step(1 / 30, 10, 10);
			world.ClearForces();
			world.DrawDebugData();
		}
	}

}