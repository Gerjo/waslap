package entities {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Time;
	import flash.events.Event;
	
	public class LineSegment extends Entity {
		private var myBody:b2BodyDef = new b2BodyDef();
		private var myBody2:b2Body;
		private var vertices:Array;
		
		public var REMOVE:String = "remove";
		
		public var start:b2Vec2 = new b2Vec2();
		public var end:b2Vec2 = new b2Vec2();
		public static var DEBUG:Boolean = true;
		
		public function LineSegment(startX:Number, startY:Number, endX:Number, endY:Number) {
			vertices = [new b2Vec2(startX, startY), new b2Vec2(endX, endY), new b2Vec2(endX + 10, endY + 10), new b2Vec2(startX + 10, startY + 10)];
			
			start.x = startX;
			start.y = startY;
			
			end.x = endX;
			end.y = endY;
			
			myBody.type = b2Body.b2_staticBody; // u no move
			
			var myCircle:b2PolygonShape = new b2PolygonShape();
			
			myCircle.SetAsArray(vertices);
			
			var myFixture:b2FixtureDef = new b2FixtureDef();
			myFixture.shape = myCircle;
			myFixture.density = 1;
			myFixture.friction = 0;
			myBody2 = getGame().getWorld().CreateBody(myBody);
			myBody2.CreateFixture(myFixture);
		}
		
		public function getBody():b2BodyDef {
			return myBody;
		}
		
		public function addLeftOffset(num:Number) : void {
			var pos:b2Vec2 = myBody2.GetPosition();
			pos.x += num;
			myBody2.SetPosition(pos);
		}
		
		override public function update(time:Time):void {
			super.update(time);
			var foo:b2Vec2 = getGame().getWorld().GetGravity().Copy();
			foo.Multiply( -myBody2.GetMass());
			myBody2.ApplyForce(foo, myBody2.GetWorldCenter());
			x = myBody2.GetPosition().x;
			y = myBody2.GetPosition().y;
			if (x < -10) dispatchEvent(new Event(REMOVE));
		}
		
		override public function render():void {
			if (DEBUG) {
				super.render();
				graphics.beginFill(0x600000);
				graphics.lineStyle(10, 0xffff00);
				graphics.moveTo(start.x, start.y);
				graphics.lineTo(end.x, end.y);
				graphics.endFill();
			}
		}
	
	}
}