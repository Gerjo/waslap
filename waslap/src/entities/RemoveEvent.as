package entities {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nico Glas
	 */
	public class RemoveEvent extends Event {
		
		public static const REMOVELINE:String = "onRemoveLine";
		
		public function RemoveEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new RemoveEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("RemoveEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}