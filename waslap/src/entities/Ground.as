package entities {
	import Box2D.Common.Math.b2Vec2;
	import datacontainer.Node;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import datacontainer.LinkedList;
	import core.*;
	
	public class Ground extends Entity {
		
		private var _isLoaded:Boolean = false;
		private var audio:ALF;
		private var currentPositiononX:int = 0;
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
			
			audio.addEventListener(audio.NEW_FRAME, onNewFrame);
		}
		
		private function onNewFrame(e:Event):void {
			++tempCount;
			var distance:int = 1000;
			
			if (_isLoaded) {
				var intensity:Number = audio.getBrightness();
				var nodepoint:b2Vec2 = new b2Vec2(currentPositiononX, 300 + intensity / 20);
				if (isNaN(nodepoint.y))
					nodepoint.y = 300;
				
				nodes.push(nodepoint);
				
				var size:uint = nodes.length;
				if (size > 1) {
					var l:LineSegment = new LineSegment(nodes[size - 1], nodes[size - 2]);
					addChild(l);
					segments.push(l);
					nodes.splice(0, 1);
				}
				currentPositiononX += 10;
			}
		}
		
		public function removeMeFromArr(me:LineSegment):void {
			for (var i:int = 0; i < segments.length; ++i) {
				if (segments[i] == me) {
					segments.splice(i, 1);
					break;
				}
			}
			removeChild(me);
		}
		
		public override function update(time:Time):void {
			super.update(time);
			
			if (segments != null) {
				for (var i:int = 0; i < segments.length; i++) {
					if (i > 0) {
						segments[i].start = segments[i - 1].end;
					}
							segments[i].addLeftOffset(-_speed);
			
				}
			}
		
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
