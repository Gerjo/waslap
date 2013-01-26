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
		public var worldScale:Number 	= 1;
		public var world:b2World		= new b2World(new b2Vec2(0, 100), true);
		
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
			myBody.position.Set(200, 200);
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
			myBody.position.Set(10, 300);
			myBody.type = b2Body.b2_staticBody;
			
			var myCircle:b2PolygonShape = new b2PolygonShape();
			//myCircle.SetAsBox(600, 100);
			
			myCircle.SetAsArray([
				new b2Vec2(0, 0),
				new b2Vec2(400, 10),
				new b2Vec2(400, 100),
				new b2Vec2(0, 100)
			]);
			
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
			if (false && gravc > 10) {
				gravc = 0;
				trace("Switched grav");
				world.GetGravity().Multiply(-1)
				
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