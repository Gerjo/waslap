package entities {
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	
	import core.*;
	
	public class Ground extends Entity {
		
		private var nodes:Array = new Array();
		private var _isLoaded:Boolean = false;
		private var _audio:ALF;
		private var intensity:Number = 0;
		private var offset = 0;
		private var line:Line;
		public function Ground() {
			_audio = new ALF("../src/assets/audio/barrywhite.mp3", 0, 500, false, 0);
			_audio.addEventListener(_audio.FILE_LOADED, onLoadComplete);
			_audio.addEventListener(_audio.NEW_FRAME, onNewFrame);
			line = new Line();
		}
		
		private function onNewFrame(e:Event):void {
			if (_isLoaded) {
				intensity = _audio.getIntensity();
				var xy:XY = new XY();
				xy.x = offset;
				xy.y = 300 - intensity / 10;
				xy.y = (xy.y < 200)? 300 : xy.y;
				if (isNaN(xy.y))
					xy.y = 300;
				line.nodes.push(xy);
				
				offset += 30;
				if (offset > Game.instance.windowSize.x) {
					line.x = 30;
					line.moveNodes();
				}
				trace(line.nodes.length);	
			}
		}
		
		private function onLoadComplete(e:Event):void {
			_audio.removeEventListener(_audio.FILE_LOADED, onLoadComplete);
			_isLoaded = true;
			_audio.startAudio();
		
		}
		
		public override function update(time:Time):void {
			
			render();
		}
		
		public override function render():void {
			if (_isLoaded) {
				
				line.render(graphics);
			}
		}
	}
}
import flash.display.Graphics;

class XY {
	public var x:Number;
	public var y:Number;
}

class Line {
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
		graphics.lineStyle(1, 0x600000);
		
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