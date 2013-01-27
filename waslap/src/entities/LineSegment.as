package entities {
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Time;
	import core.Text;
	import datacontainer.LinkedList;
	import flash.events.Event;
	import physics.XY;
	
	public class LineSegment extends Entity {
		private var myBody:b2BodyDef = new b2BodyDef();
		private var myBody2:b2Body;
		private var vertices:Array;
		
		public var REMOVE:RemoveEvent;
		public var start:b2Vec2 = new b2Vec2();
		public var end:b2Vec2 = new b2Vec2();
		public static var DEBUG:Boolean = true;
		
		private var debugText:Text;
		
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
			
			myBody2 = getGame().getWorld().CreateBody(myBody);
			myBody2.CreateFixture(myFixture);
			
		}
		
		public function getBody():b2BodyDef {
			return myBody;
		}
		
		public function addLeftOffset(num:Number) : void {
			var pos:b2Vec2 = myBody2.GetPosition();
			pos.x += num;
			x = pos.x;
			myBody2.SetPosition(pos);
		}
		
		override public function update(time:Time):void {
			super.update(time);
			
			// Sync the Entity position with whatever Box2D came up with.
			x = myBody2.GetPosition().x;
			y = myBody2.GetPosition().y;
			
			// Off-screen, notify ground to start the removal procedure.
			if (x < -25) {
				REMOVE = new RemoveEvent("onRemoveLine");
				dispatchEvent(REMOVE);
			}
		}
		
		override public function render():void {
			if (DEBUG) {
				super.render();
				graphics.beginFill(0x600000);
				graphics.lineStyle(5, 0xffff00);
				graphics.moveTo(start.x, start.y);
				graphics.lineTo(end.x, end.y);
				graphics.endFill();
			}
		}
		
		public function setText(text:String) : void {
		    if(debugText == null) {
		        addChild(debugText = new Text(""));
		    }
		    
		    debugText.setText(text);
		} 
	
	}
}
