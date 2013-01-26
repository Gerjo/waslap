package entities {
	import core.Entity;

	public class GameState extends Entity {
		
		public function GameState() {
			
		}
		
		public function hide() : void {
			visible = false;
		}
		
		public function show() : void {
			visible = true;
		}
	}
}