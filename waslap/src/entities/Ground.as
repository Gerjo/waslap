package entities {
	import Box2D.Common.Math.b2Vec2;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.display.Graphics;
	
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
				if (isNaN(intensity)) intensity = 0;
				if (segments.length >= 1)
					preEnd = segments[segments.length - 1].start.Copy();
				//if (preEnd == null) preEnd = new b2Vec2(800, 300);
				var ls:LineSegment = new LineSegment(preEnd.x, preEnd.y, 800 - _offset, 300 + intensity * 0.05);
				
				addChild(ls);
				segments.push(ls);
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