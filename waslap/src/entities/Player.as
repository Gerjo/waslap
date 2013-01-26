package entities {
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Collision;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Game;
	import core.Message;
	import core.Time;
	import core.IUpdatable;
	
	public class Player extends Entity {
		private var _isFlipped:Boolean = false;
		private var _gravity:b2Vec2    = new b2Vec2(0.0, 0.35);
		private var myBody:b2BodyDef   = new b2BodyDef();
		
		public function Player() {
			myBody.position.Set(100, 100);
			myBody.type = b2Body.b2_dynamicBody;
			var myCircle:b2CircleShape = new b2CircleShape(10);
			var myFixture:b2FixtureDef = new b2FixtureDef();
			myFixture.shape = myCircle;
			myFixture.density = 1;
			myFixture.friction = 1;
			
			var body:b2Body = getGame().getWorld().CreateBody(myBody);
			body.CreateFixture(myFixture);
			
		}
		
		override public function render():void {
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 10);
			//graphics.drawCircle(0, -10, 3);
			graphics.endFill();
		}
		
		override public function update(time:Time):void {
			super.update(time);
			x = myBody.position.x;
			y = myBody.position.y;
			
			trace("player pos: ", x, " ", y);
		}
		
		override public function handleMessage(msg:Message):void {
			super.handleMessage(msg);
			
			if (msg.type == "KeyboardEvent" && msg.payload == "jump") {
				jump();
			} else if (msg.type == "KeyboardEvent" && msg.payload == "flip") {
				flip();
			}
		}
		
		public function jump():void {
			_isFlipped ? _acceleration.y = 10 : _acceleration.y = -10;
		}
		
		public function flip():void {
			if (!_isFlipped) {
				this.y += this.height;
				this.scaleY *= -1;
			} else {
				this.y -= this.height;
				this.scaleY *= -1;
			}
			
			_isFlipped = _isFlipped ? false : true;
		}
	}
}