package physics {
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Nico Glas
	 */
	public class Line {
		
		public var nodes:Array;
		public var distance:Number = 0;
		//public var chain:b2EdgeShape;
		public var x:Number = 0, y:Number;
		
		public function Line(x:Number = 10, y:Number=300) {
			nodes = new Array();
			this.x = x; this.y = y;
		}
		
		public function push(val:XY):void {
			nodes.push(val);
		}
		
		public function render(graphics:Graphics, color:uint):void {
			//graphics.clear();
			graphics.lineStyle(5, color);
			
			graphics.moveTo(nodes[0].x, nodes[0].y);
			for (var i:int = 1; i < nodes.length; ++i) {
				graphics.lineTo(nodes[i].x, nodes[i].y);
			}
			graphics.endFill();
		}
		
		public function moveNodes():void {
			for (var i:int = 1; i < nodes.length; ++i) {
				nodes[i].x -= x;
			}
			distance += 5;
		}
		
		public function remove(nodesToRemove:int):void {
			nodes.splice(0, nodesToRemove);
		}
	
	}

}
class XY {
	public var x:Number;
	public var y:Number;
}