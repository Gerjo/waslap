package core {
	public class Message {
		public var type:String = "";
		public var payload:Object = null;
		
		public function Message(type:String, payload:Object) {
			this.type = type;
			this.payload = payload;
		}	
	}
}