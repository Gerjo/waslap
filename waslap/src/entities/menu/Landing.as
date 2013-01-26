package entities.menu {
	import core.Entity;
	import core.Image;
	import entities.Button;
	import entities.GameState;

	public class Landing extends GameState {
		private var noteImage:Image;
		private var beats:Array = new Array();
		
		
		public function Landing() {
			
		}
		
		override public function init():void {
			super.init();
			
			addChild(noteImage = new Image("note"));
			
			addChild(beats[0] = new Beat());
			addChild(beats[1] = new Beat());
			addChild(beats[2] = new Beat());
			
			
			var offset:Number = 90;
			for (var i:int = 0; i < beats.length; ++i) {
				beats[i].y = offset += 102;
				beats[i].x = 50;
			}
			
			var buttons:Array = [
				new Button("playbutton", "playbuttonpressed", "", function () : void {
					getGame().menuState.hide();
					getGame().gameState.show();
				}, function () : void {
					beats[0].showPulse();
					beats[1].showStatic();
					beats[2].showStatic();
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
				}),
				
				new Button("controlsbutton", "controlsbuttonpressed", "", function () : void {
					trace("controlsbutton");
				}, function () : void {
					beats[0].showStatic();
					beats[1].showPulse();
					beats[2].showStatic();
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
				}),
				
				new Button("creditsbutton", "creditsbuttonpressed", "",  function () : void {
					trace("creditsbutton");
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showPulse();
				}, function () : void {
					beats[0].showStatic();
					beats[1].showStatic();
					beats[2].showStatic();
				})
			];
			
			// Top button:
			var last:Button = buttons[0];
			addChild(last);
			last.y = 180;
			Button.AlignLeft(noteImage, last);
			
			// Align others:
			for (var i:int = 1; i < buttons.length; ++i) {
				addChild(buttons[i]);
				Button.AlignUnder(last, buttons[i]);
				Button.AlignLeft(noteImage, buttons[i]);
				last = buttons[i];
			}
		}
	}
}