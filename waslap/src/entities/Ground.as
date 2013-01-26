package entities {
	import Box2D.Common.Math.b2Vec2;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.display.Graphics;
	import physics.XY;
	
	import core.*;
	
	public class Ground extends Entity {
		
		private var _isLoaded:Boolean = false;
		private var audio:ALF;
		private var _offset:int = 50;
		private var _speed:int = 15;
		private var nodes:Array;
		public var score:int;
		public var segments:Array;
		public var preEnd:b2Vec2;
		
		public function Ground() {
			audio = new ALF("../src/assets/audio/barrywhite.mp3", 0, 30, false, 0);
			audio.addEventListener(audio.FILE_LOADED, onFileLoad);
		}
		
		private function onFileLoad(e:Event):void {
			audio.startAudio();
			segments = new Array();
			nodes = new Array();
			_isLoaded = true;
			var ls:LineSegment = new LineSegment(0, 300, 800, 300);
			addChild(ls);
			segments.push(ls);
			//preEnd = ls.end.Copy();
			audio.addEventListener(audio.NEW_FRAME, onNewFrame);
		}
		
		private function onNewFrame(e:Event):void {
			if (_isLoaded) {
				var intensity:Number = audio.getIntensity();
				
				
				var xy:XY = new XY();
				xy.x = _offset;
				xy.y = 300 - intensity / 20 ;
				if (segments.length >= 1)
					preEnd = segments[segments.length - 1].start.Copy();
				//if (preEnd == null) preEnd = new b2Vec2(800, 300);
				
				if (isNaN(xy.y)) xy.y = 300;
				nodes.push(xy);
				var index:int = nodes.length;
				if (nodes.length > 1) {
					var ls:LineSegment = new LineSegment(nodes[index - 2].x, nodes[index - 2].y, nodes[index - 1].x, nodes[index - 1].y);
					
				addChild(ls);
				segments.push(ls);
				}
				_offset += 30;
			}
		}
		
		private function removeLine(e:Event):void {
			segments.splice(segments.indexOf(e.target as LineSegment));
		}
		
		public override function update(time:Time):void {
			super.update(time);
			for each (var ls:LineSegment in segments) {
				ls.addLeftOffset(-_speed);
			}
		}
		
		public override function render():void {
			if (_isLoaded) {
				super.render();
				graphics.clear();
			}
		}
	}
}