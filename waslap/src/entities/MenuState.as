package entities {
	import core.Entity;
	import core.Image;
	import entities.menu.Landing;

	public class MenuState extends GameState {
		private var landing:Landing;
		
		
		public function MenuState() {
			
		}
		
		public override function init() : void {
			addChild(new Image("background"));

			addChild(landing = new Landing());
			addChild(new FrameCounter());
			
			
		}
		
	}
}