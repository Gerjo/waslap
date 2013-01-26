package core {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Input extends Sprite {
		
		private var _jumpKey:Boolean = false;
		private var _flipKey:Boolean = false;
		
		public function Input() {
		}
		
		public function init() : void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEventDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyEventUp);
		}
		
		private function keyEventDown(e:KeyboardEvent) : void {
			var msg:Message;
			if (e.keyCode == Keyboard.SPACE) {
				if (_jumpKey != true) {
					_jumpKey = true;
					broadcastMessage(new Message("KeyboardEvent", "jump"));
				}
			}
			else if (e.keyCode == Keyboard.M) {
				if (_flipKey != true) {
					_flipKey = true;
					broadcastMessage(new Message("KeyboardEvent", "flip"));
				}
			}
		}
		
		private function keyEventUp(e:KeyboardEvent) : void {
			if (e.keyCode == Keyboard.SPACE) {
				if (_jumpKey != false)
					_jumpKey = false;
			}
			else if (e.keyCode == Keyboard.M) {
				if (_flipKey != false)
					_flipKey = false;
			}
		}
		
		private function broadcastMessage(msg:Message) : void {
			Game.instance.handleMessage(msg);
		}
	}
}