package entities.menu {
	import core.Entity;
	import entities.Button;

	public class Landing extends Entity {
		
		public function Landing() {
			
		}
		
		override public function init():void {
			super.init();
			
			var buttons:Array = [
				new Button("playbutton", "playbuttonpressed", "", function () : void {
					getGame().menuState.hide();
					getGame().gameState.show();
				}),
				
				new Button("controlsbutton", "controlsbuttonpressed", "", function () : void {
					trace("controlsbutton");
				}),
				
				new Button("creditsbutton", "creditsbuttonpressed", "",  function () : void {
					trace("creditsbutton");
				})
			];
			
			// Top button:
			var last:Button = buttons[0];
			addChild(last);
			last.x = (getGame().windowSize.x - last.width) * 0.5;
			last.y = 100;
			
			// Align others:
			for (var i:int = 1; i < buttons.length; ++i) {
				addChild(buttons[i]);
				Button.AlignUnder(last, buttons[i]);
				last = buttons[i];
			}
		}
	}
}