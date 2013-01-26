package entities {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Time;
	
	public class LineSegment extends Entity {
		private var myBody:b2BodyDef = new b2BodyDef();
		private var vertices:Array;
		
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
			var body:b2Body = getGame().getWorld().CreateBody(myBody);
			body.CreateFixture(myFixture);
		}
		
		public function getBody():b2BodyDef {
			return myBody;
		}
		
		override public function update(time:Time):void {
			super.update(time);
			x = myBody.position.x;
			y = myBody.position.y;
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