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
		private var nodes:LinkedList;
		public var score:int;
		public var segments:LinkedList;
		public var preEnd:b2Vec2;
		public var tempCount:int;
		
		public function Ground() {
			audio = new ALF("../src/assets/audio/barrywhite.mp3", 0, 30, false, 0);
			audio.addEventListener(audio.FILE_LOADED, onFileLoad);
		}
		
		private function onFileLoad(e:Event):void {
			audio.startAudio();
			segments = new LinkedList();
			nodes = new LinkedList();
			
			_isLoaded = true;
			//var ls:LineSegment = new LineSegment(0, 300, 800, 300);
			//addChild(ls);
			//segments.insertHead(ls);
			
			audio.addEventListener(audio.NEW_FRAME, onNewFrame);
		}
		
		private function onNewFrame(e:Event):void {
			++tempCount;
			if (_isLoaded) {
				var intensity:Number = audio.getIntensity();
				
				var xy:XY = new XY();
				xy.x = _offset;
				xy.y = 300 - intensity / 20;
				
				if (isNaN(xy.y))
					xy.y = 300;
				nodes.insertHead(xy);
				var head:Node = nodes.head;
				var index:int = nodes.length;
				if (nodes.length > 1) {
					var lineseg:LineSegment = new LineSegment((head.getNext().getData() as XY).x, (head.getNext().getData() as XY).y, (head.getData() as XY).x, (head.getData() as XY).y);
					addChild(lineseg);
					segments.insertHead(lineseg);
				}
				
				_offset += 30;
				segments.foreach(function(item:LineSegment):void {
					item.addLeftOffset( -_speed);
				});
				var node:Node = segments.tail;
				while (node != null) {
					if (node.nextNode != null) {
						var line:LineSegment = (node.getData() as LineSegment);
						var pastline:LineSegment = (node.nextNode.getData() as LineSegment);
						line.start = pastline.end;
					}
					node = node.previousNode;
				}
			}
		}
		
		private function removeLine():void {
			while (segments.length > 100) {
				segments.popTail();
			}
		}
		
		public override function update(time:Time):void {
			super.update(time);
			if (segments != null && segments.length > 100) {
				removeLine();
			}
		}
		
		public override function render():void {
			super.render();
			if (_isLoaded) {
				
				graphics.clear();
			}
		}
	}
}