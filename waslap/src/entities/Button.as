package entities 
{
	import core.Entity;
	import core.Image;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Gerard Meier
	 */
	public class Button extends Image {
		
		public static function AlignUnder(top:Button, bottom:Button, spacing:Number = 10) {
			bottom.x = top.x;
			bottom.y = top.y + top.height;
		}
		
		private var normal:String;
		private var hover:String;
		private var click:String;
		private var image:Image;
		private var clickCallback:Function;
		
		public function Button(normal:String, hover:String = "", click:String = "", clickCallback:Function = null) {
			super(normal);
			
			this.clickCallback = clickCallback;
			this.normal        = normal;
			this.hover         = (hover != "") ? hover : normal;
			this.click         = (click != "") ? click : hover; // If there is no click, then default to the hover action.
			buttonMode         = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, onHover);
			addEventListener(MouseEvent.MOUSE_OUT,  onExit);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
		}
		
		public function onHover(e:Event) : void {
			load(hover);
		}
		
		public function onExit(e:Event) : void {
			load(normal);
		}
		
		public function onMouseDown(e:Event) : void {
			load(click);
			
			if(clickCallback != null) {
				clickCallback();
			} else {
				trace("No click event callback function for button with src: '" + normal + "'.");
			}
		}
		
		public function onMouseUp(e:Event) : void {
			load(hover);
		}
	}
}