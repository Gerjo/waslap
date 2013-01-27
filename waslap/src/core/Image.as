package core {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class Image extends Entity {
		private var _isCentered:Boolean = false;
		private var _name:String = "";
		
		public function get imageName() : String {
			return _name;
		}
		
		public function Image(name:String = "") {
			if (name != "") {
				load(name);
			}
		}
		
		public override function render() : void {
			
		}
		
		public function center() : Image {
			if (_isCentered) {
				return this;
			}
			_isCentered = true;
			
			x -= width * 0.5;
			y -= height * 0.5;
			
			return this;
		}
		
		public function absolute() : Image {
			if (!_isCentered) {
				return this;
			}
			_isCentered = false;
			
			x += width * 0.5;
			y += height * 0.5;
			
			return this;
		}
		
		public function load(name:String) : Image {
			_name       = name;
			_isCentered = false;
			
			while(numChildren > 0) {
				removeChildAt(0);
			}
			
			addChild(Assets.load(name));
			return this;
		}
	}
}