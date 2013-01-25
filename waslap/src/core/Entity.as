package core {
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Bound;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.*
	import core.*;
	
	public class Entity extends Sprite implements IUpdatable, IRenderable {
		public function Entity() {
			
		}
		
		public function update(time:Time) : void {
			for (var i:int = 0; i < numChildren; ++i) {
				// Incase of 0 FPS, remove check.
				if(getChildAt(i) is IUpdatable) {
					(getChildAt(i) as IUpdatable).update(time);
				}
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			(child as IRenderable).render();
			
			return child;
		}
		
		public function render() : void {
			// Automatically called when calling "addChild" on a entity.
		}

		public function getGame() : Game {
			// So you don't need to feel guilty about calling a static, instead of using
			// proper dependency injection.
			return Game.instance;
		}
		
		public function setPosition(pos:b2Vec2) : Entity {
			x = pos.x;
			y = pos.y;
			return this;
		}
		
		public function getPosition() : b2Vec2 { 
			return new b2Vec2(x, y);
		}
		
		public function getSize() : b2Vec2 {
			return new b2Vec2(width, height);
		}
		
		public function getBox() : b2AABB {
			var box:b2AABB = new b2AABB();
			box.lowerBound = getPosition();
			box.upperBound = new b2Vec2(width + x, height + y);
			return box;
		}
	}
}