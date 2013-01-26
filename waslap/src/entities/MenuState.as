package entities {
	import core.Entity;
	import core.Image;
	import entities.menu.Landing;

	public class MenuState extends GameState {
		private var landing:Landing;
		
		
		public function MenuState() {
			
		}
		
		public function toggle(name:String) {
			landing.hide();
			
			if (this[name] != null) {
				(this[name] as GameState).hide();
			} else {
				throw new Error("Cannot set '" + name + "' to visible. Variable not found in Menustate.as");
			}
		}
		
		public override function init() : void {
			addChild(new Image("background"));

			addChild(landing = new Landing());
			addChild(new FrameCounter());
			
			
		}
		
	}
}