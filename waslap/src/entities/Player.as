package entities {
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Collision;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import core.Entity;
	import core.Message;
	import core.Time;
	import core.IUpdatable;
	
	public class Player extends Entity {
		private var _isFlipped:Boolean = false;
		private var _gravity:b2Vec2 = new b2Vec2(0.0, 0.35);
		
		public function Player() {
		}
		
		override public function render():void {
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 10);
			graphics.drawCircle(0, -10, 3);
			graphics.endFill();
		}
		
		override public function update(time:Time):void {
			for (var i:int = 0; i < numChildren; ++i) {
				// Incase of 0 FPS, remove check.
				if (getChildAt(i) is IUpdatable) {
					(getChildAt(i) as IUpdatable).update(time);
				}
			}
			
			var difference:b2Vec2 = doCollisionStuff();
			
			_velocity.Add(_acceleration);
			_acceleration = new b2Vec2(0, 0);
			
			_velocity.x = _velocity.x * _friction.x;
			_velocity.y = _velocity.y * _friction.y;
			
			_velocity.Add(doCollisionStuff());
			
			this.x += _velocity.x;
			this.y += _velocity.y;
		}
		
		private function doCollisionStuff() : b2Vec2 {
			var isColliding:Boolean = false;
			var lineSegment:b2PolygonShape = getGame().soundLine.getLine().getPolygonShape(this.x)
			
			var vert:Array = new Array();
			vert.push(new b2Vec2(this.x, this.y));
			vert.push(new b2Vec2(this.x, this.y + this.width));
			vert.push(new b2Vec2(this.x + this.width, this.y + this.height));
			vert.push(new b2Vec2(this.x + this.width, this.y));
			
			var me:b2PolygonShape = new b2PolygonShape();
			me.SetAsArray(vert, vert.length);
			
			var manifold:b2Manifold = new b2Manifold();
			var diffA:b2Transform = new b2Transform();
			var diffB:b2Transform = new b2Transform();
			b2Collision.CollidePolygons(manifold, lineSegment, diffA, me, diffB);
			
			return diffB.position;
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