package physics {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Graphics;
	
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
		
		public function getPolygonShape(positionX:Number) : b2PolygonShape { 
			var i:int;
			for (i = 0; i < nodes.length; ++i) {
				if (nodes[i].x == positionX) {
					break;
				}
			}
			
			var vert:Array = new Array();
			
			if (i > 0) {
				vert.push(new b2Vec2(nodes[i - 1].x, nodes[i - 1].y));
				vert.push(new b2Vec2(nodes[i - 1].x, nodes[i - 1].y - 1));
				vert.push(new b2Vec2(nodes[i].x, nodes[i].y));
				vert.push(new b2Vec2(nodes[i].x, nodes[i].y - 1));
			}
			else {
				vert.push(new b2Vec2(nodes[i].x, nodes[i].y));
				vert.push(new b2Vec2(nodes[i].x, nodes[i].y - 1));
				vert.push(new b2Vec2(nodes[i + 1].x, nodes[i + 1].y));
				vert.push(new b2Vec2(nodes[i + 1].x, nodes[i + 1].y - 1));
			}
			
			var lineSegment:b2PolygonShape = new b2PolygonShape();
			lineSegment.SetAsArray(vert, vert.length);
			
			return lineSegment;
		}
	}
}

class XY {
	public var x:Number;
	public var y:Number;
}