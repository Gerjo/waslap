package entities {
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
			
			_velocity.Add(_acceleration);
			_acceleration = new b2Vec2(0, 0);
			
			_velocity.x = _velocity.x * _friction.x;
			_velocity.y = _velocity.y * _friction.y;
			
			if (!_isFlipped && this.y < getGame().halfWindowSize.y) // should become a ground check.
				_velocity.Add(_gravity);
			
			else if (_isFlipped && this.y > getGame().halfWindowSize.y) // should become a ground check.
				_velocity.Subtract(_gravity);
			
			this.x += _velocity.x;
			this.y += _velocity.y;
		
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