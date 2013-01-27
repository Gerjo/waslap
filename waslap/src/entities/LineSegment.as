package entities {
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Time;
	import datacontainer.LinkedList;
	import flash.events.Event;

	public class LineSegment extends Entity {
		private var myBody:b2BodyDef = new b2BodyDef();
		private var myBody2:b2Body;
		private var vertices:Array;
		
		public var REMOVE:RemoveEvent;
		public var start:b2Vec2 = new b2Vec2();
		public var end:b2Vec2 = new b2Vec2();
		public static var DEBUG:Boolean = true;
		
		public function LineSegment(start:b2Vec2, end:b2Vec2) {
			vertices = [start, 
						end, 
						new b2Vec2(end.x, end.y + 10), 
						new b2Vec2(start.x, start.y + 10)];
			
			this.start  = start;
			this.end    = end;
			myBody.type = b2Body.b2_staticBody; // u no move

			var myCircle:b2PolygonShape = new b2PolygonShape();
			myCircle.SetAsArray(vertices);
			
			var myFixture:b2FixtureDef = new b2FixtureDef();
			myFixture.shape = myCircle;
			
			myBody2 = getGame().getWorld().CreateBody(myBody);
			myBody2.CreateFixture(myFixture);
			
			setPosition(start);
		}
		
		override public function setPosition(pos:Object, y:Number = 0):Entity 
		{
			if (pos is Number) myBody2.SetPosition(new b2Vec2(pos as Number, y));
			else if (pos is b2Vec2) myBody2.SetPosition(pos as b2Vec2);
			return super.setPosition(pos, y);
		}
		
		public function getBody():b2BodyDef {
			return myBody;
		}
		
		public function addLeftOffset(num:Number) : void {
			var pos:b2Vec2 = myBody2.GetPosition();
			pos.x += num;
			setPosition(pos);
		}
		
		override public function update(time:Time):void {
			super.update(time);
			x = myBody2.GetPosition().x;
			y = myBody2.GetPosition().y;
			if (x < -25) {
				(parent as Ground).removeMeFromArr(this);
			}
		}
		
		override public function render():void {
			if (DEBUG) {
				super.render();
				graphics.beginFill(0x600000);
				graphics.lineStyle(5, 0xffff00);
				graphics.moveTo(0, 0);
				graphics.lineTo(end.x - start.x, end.y - start.y);
				graphics.endFill();
			}
		}
	
	}
}