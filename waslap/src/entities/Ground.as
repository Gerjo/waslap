package entities {
	import Box2D.Common.Math.b2Vec2;
	import datacontainer.Node;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import physics.XY;
	import datacontainer.LinkedList;
	import core.*;
	
	public class Ground extends Entity {
		
		private var _isLoaded:Boolean = false;
		private var audio:ALF;
		private var _offset:int = 10;
		private var _speed:int = 10;
		private var nodes:Array;
		public var score:int;
		public var segments:Array;
		public var preEnd:b2Vec2;
		public var tempCount:int;

		
		public function Ground() {
			audio = new ALF("../src/assets/audio/menu128.wav", 0, 30, true, 0);
			audio.addEventListener(audio.FILE_LOADED, onFileLoad);
		}
		
		private function onFileLoad(e:Event):void {
			audio.startAudio();
			segments = new Array();
			nodes = new Array();
			
			_isLoaded = true;
			//var ls:LineSegment = new LineSegment(0, 300, 800, 300);
			//addChild(ls);
			//segments.insertHead(ls);
			
			audio.addEventListener(audio.NEW_FRAME, onNewFrame);
		}
		
		private function onNewFrame(e:Event):void {
			++tempCount;
			if (_isLoaded && segments.length < 101) {
				var intensity:Number = audio.getIntensity();
				
				var xy:XY = new XY();
				xy.x = _offset;
				xy.y = 300 + intensity / 20;
				
				if (isNaN(xy.y))
					xy.y = 300;
				nodes.push(xy);
				var index: int = nodes.length;
				if (index > 1) {
					var lineseg:LineSegment = new LineSegment(nodes[index - 1].x, nodes[index - 1].y, nodes[index - 2].x, nodes[index - 2].y);
					lineseg.addEventListener(RemoveEvent.REMOVELINE, removeLine);
					segments.push(lineseg);
					addChild(lineseg);
				}
				
				_offset += 30;
				for each(var ls:LineSegment in segments) {
					ls.addLeftOffset( -_speed);
				}
				var node:Node = segments.tail;
				
			}
		}
		
		private function removeLine(e:RemoveEvent):void {
		    // Gerjo: attempt to remove e.origin, instead of for loop routine.
		    // ^^ if anything, it should increase performance.
			for (var i:int = 0; i < segments.length; i++) {
				if (segments[i].start.x < 50) {
					removeChild(segments[i]);
					segments.splice(i, 1);
					// Quite possibly we need this here:
					// i = (i > 0) ? i - 1 : 0;
					// or
					// --i;
					// ^^ since the array indices are shifted to the left.
				}
			}
		}
		
		public override function update(time:Time):void {
			super.update(time);
			//trace("progress: " + audio.loadProgress);
		}
		
		public override function render():void {
			super.render();
			if (_isLoaded) {
				
				graphics.clear();
			}
		}
	}
}
