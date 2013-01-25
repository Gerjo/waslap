package entities 
{
	import Box2D.Common.Math.b2Vec2;

	import core.*;
	public class Ground extends Entity {
		
		private var nodes:Array = new Array();
		
		public function Ground() {
			
			var leftOffset:Number = 0;
			for (var i:int; i < 100; ++i) {
				leftOffset += Math.random() * 50 + 40;
				nodes.push(new b2Vec2(leftOffset, Math.random() * 100));
			}
			
			y = getGame().halfWindowSize.y;
		}
		
		public override function update(time:Time) : void {
			x -= 200 * time.delta;
			
			//render();
			
		}
		
		public override function render() : void {
			graphics.clear();
			graphics.lineStyle(1, 0x600000);
			
			graphics.moveTo(nodes[0].x, nodes[0].y);
			for(var i:int = 1; i < nodes.length; ++i ) { 
				graphics.lineTo(nodes[i].x, nodes[i].y);
			}
			
			graphics.endFill();
		}
	}
}