package entities {
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	import physics.Line;
	
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
				if(Math.random() > 0.49){
					xy.y = 300 - intensity / 20 ;
					xy.y = (xy.y < 150)? 300 : xy.y;
				}else {
					xy.y = 300 + intensity / 20 ;
					xy.y = (xy.y > 450)? 300 : xy.y;
				}
				
				if (isNaN(xy.y))
					xy.y = 300;
				line.nodes.push(xy);
				
				offset += 50;
				if (offset > Game.instance.windowSize.x) {
					line.x = 5;
					line.moveNodes();
				}
				trace(intensity);	
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