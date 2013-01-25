package core {
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
	}
}