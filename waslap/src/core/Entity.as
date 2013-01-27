package core {
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Bound;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.*
	import core.*;
	
	public class Entity extends Sprite implements IUpdatable, IRenderable, IMessageHandler, IInit {
		protected var _velocity:b2Vec2 = new b2Vec2(0, 0);
		protected var _acceleration:b2Vec2 = new b2Vec2(0, 0);
		protected var _friction:b2Vec2 = new b2Vec2(0.9, 0.9);
		
		public function Entity() {
		
		}
		
		public function init() : void {
			
		}
		
		public function update(time:Time):void {
			for (var i:int = 0; i < numChildren; ++i) {
				// Incase of 0 FPS, remove check.
				if (getChildAt(i) is IUpdatable) {
					(getChildAt(i) as IUpdatable).update(time);
				}
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			
			if (child is IInit) {
				(child as IInit).init();
			}
			
			if (child is IRenderable) {
				(child as IRenderable).render();
			}
			
			return child;
		}
		
		public function render():void {
			// Automatically called when calling "addChild" on a entity.
		}
		
		public function handleMessage(msg:Message):void {
			for (var i:int = 0; i < numChildren; ++i) {
				if (getChildAt(i) is Entity) {
					(getChildAt(i) as Entity).handleMessage(msg);
				}
			}
		}
		
		public function getGame():Game {
			// So you don't need to feel guilty about calling a static, instead of using
			// proper dependency injection.
			return Game.instance;
		}
		
		public function setPosition(pos:Object, y:Number = 0):Entity {
			if (pos is b2Vec2) {
				this.x = (pos as b2Vec2).x;
				this.y = (pos as b2Vec2).y;
			} else {
				this.x = pos as Number;
				this.y = y;
			}
			
			return this;
		}
		
		public function getPosition():b2Vec2 {
			return new b2Vec2(x, y);
		}
		
		public function getSize():b2Vec2 {
			return new b2Vec2(width, height);
		}
		
		public function getBox():b2AABB {
			var box:b2AABB = new b2AABB();
			box.lowerBound = getPosition();
			box.upperBound = new b2Vec2(width + x, height + y);
			return box;
		}
	}
}