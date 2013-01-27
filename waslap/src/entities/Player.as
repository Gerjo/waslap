package entities {
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Collision;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Entity;
	import core.Game;
	import core.Message;
	import core.ParticleEmitter;
	import core.SpriteSheet;
	import core.Time;
	import core.IUpdatable;
	
	public class Player extends Entity {
		private var _isFlipped:Boolean = false;
		private var _isJumping:Boolean = false;
		private var _onGround:Boolean = false;
		
		private var myBody:b2BodyDef = new b2BodyDef();
		private var myBody2:b2Body;
		
		private var spartacles:ParticleEmitter;
		
		private var prevPos:b2Vec2 = new b2Vec2();
		
		private var jumpSteps:Number = 0;
		
		public function Player() {
			myBody.position.Set(Math.random() * 800, 100);
			myBody.type = b2Body.b2_dynamicBody;
			var myCircle:b2PolygonShape = new b2PolygonShape();
			myCircle.SetAsBox(10, 10);
			var myFixture:b2FixtureDef = new b2FixtureDef();
			var myMass:b2MassData = new b2MassData();
			myMass.mass = 0.00000002;
			
			myFixture.shape = myCircle;
			myFixture.density = 1;
			myFixture.friction = 0.00091;
			myFixture.restitution = 0;
			
			myBody2 = getGame().getWorld().CreateBody(myBody);
			myBody2.SetMassData(myMass);
			myBody2.CreateFixture(myFixture);
			
			addChild(spartacles = new ParticleEmitter(new b2Vec2(-1, -1), 50, 0xffffff, 1, -1, 10, 0.1, 0.015, 200));
			addChild(new SpriteSheet("running", 100, 100).center().top( -75));
		}
		
		override public function render():void {
			super.render();
		}
		
		override public function update(time:Time):void {
			super.update(time);
			x = myBody2.GetPosition().x;
			y = myBody2.GetPosition().y;
			
			if (myBody2.GetContactList() != null)
				_onGround = true;
			else
				_onGround = false;
		
			spartacles.direction = prevPos.Copy();
			spartacles.direction.Subtract(getPosition());
			spartacles.direction.Normalize();
			
			prevPos = getPosition();
			
			
			if (jumpSteps > 0) {
				if (!_isFlipped) {
					var v:b2Vec2 = myBody2.GetLinearVelocity();
					v.y = 10;
					myBody2.SetLinearVelocity(v);
					myBody2.ApplyForce(new b2Vec2(0, -3000000), myBody2.GetWorldCenter());
				} else {
					myBody2.ApplyForce(new b2Vec2(0, 3000000), myBody2.GetWorldCenter());
				}
				
				--jumpSteps;
			}
		}
		
		override public function handleMessage(msg:Message):void {
			super.handleMessage(msg);
			
			if (msg.type == "KeyboardEvent" && msg.payload == "jump") {
				if (_onGround)
					jump();
			} else if (msg.type == "KeyboardEvent" && msg.payload == "flip") {
				if (_onGround)
					flip();
			}
		}
		
		public function jump():void {
			if (_isJumping) {
				return;
			}
			
			jumpSteps = 30;
			
			_isJumping = false;
		}
		
		public function flip():void {
			var position:b2Vec2 = myBody2.GetPosition();
			var gravity:b2Vec2 = getGame().getWorld().GetGravity();
			
			if (!_isFlipped) {
				position.y += this.height;
				gravity.y *= -1;
				this.scaleY *= -1;
			} else {
				position.y -= this.height;
				gravity.y *= -1;
				this.scaleY *= -1;
			}
			
			myBody2.SetPosition(position);
			getGame().getWorld().SetGravity(gravity);
			
			_isFlipped = _isFlipped ? false : true;
		}
	}
}