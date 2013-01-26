package physics {
	
	/**
	 * ...
	 * @author Nico Glas
	 */
	public class Line {
		
		public var nodes:Array;
		public var x:Number = 0, y:Number;
		
		public function Line() {
			nodes = new Array();
		}
		
		public function push(val:XY):void {
			nodes.push(val);
		}
		
		public function render(graphics:Graphics):void {
			graphics.clear();
			graphics.lineStyle(5, 0x600000);
			
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