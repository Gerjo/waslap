package entities {
	import Box2D.Common.Math.b2Vec2;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import physics.Line;
	
	import core.*;
	
	public class Ground extends Entity {
		
		private var _isLoaded:Boolean = false;
		private var _audio:ALF;
		private var intensity:Number = 0;
		private var flux:Number = 0;
		private var brightness:Number = 0;
		private var offset:int = 0;
		private var lineIntens:Line;
		private var lineFlux:Line;
		private var lineBright:Line;
		public var score:int;
		
		public function Ground() {
			_audio = new ALF("../src/assets/audio/barrywhite.mp3", 0, 60, false, 0);
			_audio.addEventListener(_audio.FILE_LOADED, onLoadComplete);
			_audio.addEventListener(_audio.NEW_FRAME, onNewFrame);
			lineIntens = new Line(300);
			lineFlux = new Line(100);
			lineBright = new Line(500);
		}
		
		private function onNewFrame(e:Event):void {
			if (_isLoaded) {
				intensity = _audio.getIntensity();
				brightness = _audio.getBrightness();
				flux = _audio.getFlux();
				var xy:XY = genXY(intensity, lineIntens.y);
				lineIntens = genLine(xy,lineIntens);
			}
		}
		
		private function genXY(val:Number,yval:Number):XY {
			var xy:XY = new XY();
			xy.x = offset;
			if (Math.random() > 0.50) {
				xy.y = yval - val / 20;
				xy.y = (xy.y < (yval * 0.5)) ? yval : xy.y;
			} else {
				xy.y = yval + val / 20;
				xy.y = (xy.y > (yval * 1.5)) ? yval : xy.y;
			}
			return xy;
		}
		private function genLine(xy:XY, val:Line):Line {
			var retval:Line = (val)? val : new Line();
			if (isNaN(xy.y))
					xy.y = val.y;
				retval.nodes.push(xy);
				var nodes:Array = retval.nodes;
				if (nodes.length > 1) {
					var ls:LineSegment = new LineSegment(nodes[nodes.length - 1].x, nodes[nodes.length - 1].y, nodes[nodes.length - 2].x, nodes[nodes.length - 2].y);
					retval.segments.push(ls);
					addChild(ls);
				}
				offset += 10;
				if (offset > Game.instance.windowSize.x) {
					retval.x = 5;
					retval.moveNodes();
				}
				if (lineIntens.distance >= 100 && lineIntens.distance % 100 == 0) {
					score++;
				}
				return retval;
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
				graphics.clear();
				lineIntens.render(graphics, 0x0000FF);
			}
		}
	}
}
import flash.display.Graphics;

class XY {
	public var x:Number;
	public var y:Number;
}