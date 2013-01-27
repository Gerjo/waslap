package entities.menu {
	import core.Entity;
	import core.Image;
	import entities.Button;
	import entities.GameState;

	public class Landing extends GameState {
		private var noteImage:Image;
		private var beats:Array = new Array();
		private var fuses:Array = new Array();
		
		
		public function Landing() {
			
		}
		
		override public function init():void {
			super.init();
			addChild(noteImage = new Image("note"));
			
			var moreOffsetX:Number = 30;
			var moreOffsetY:Number = -30;
			
			var offset:Number = 90 + moreOffsetY;
			var offsetFuse:Number = -142 + moreOffsetY;
			for (var i:int = 0; i < 3; ++i) {
				addChild(fuses[i] = new Image("fuse"));
				addChild(beats[i] = new Beat());
				
				beats[i].x = 50 + moreOffsetX;
				beats[i].y = offset += 102;
				
				fuses[i].x = 85 + moreOffsetX;
				fuses[i].y = offsetFuse += 102;
				fuses[i].visible = false;
			}
			
			var buttons:Array = [
				new Button("playbutton", "playbuttonpressed", "", function () : void {
					getGame().menuState.hide();
					getGame().gameState.show();
				}, function () : void {
					beats[0].showPulse();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[0].visible = true;
				}, function () : void {
					beats[0].showStatic();
					fuses[0].visible = false;
				}),
				
				new Button("controlsbutton", "controlsbuttonpressed", "", function () : void {
					trace("controlsbutton");
				}, function () : void {
					beats[0].showStatic();
					beats[1].showPulse();
					beats[2].showStatic();
					fuses[1].visible = true;
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[1].visible = false;
				}),
				
				new Button("creditsbutton", "creditsbuttonpressed", "",  function () : void {
					trace("creditsbutton");
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showPulse();
					fuses[2].visible = true;
					
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
					fuses[2].visible = false;
				})
			];
			
			// Top button:
			var last:Button = buttons[0];
			addChild(last);
			last.y = 180;
			Button.AlignLeft(noteImage, last);
			
			// Align others:
			for (var j:int = 1; j < buttons.length; ++j) {
				addChild(buttons[i]);
				Button.AlignUnder(last, buttons[i]);
				Button.AlignLeft(noteImage, buttons[i]);
				last = buttons[i];
			}
		}
	}
}