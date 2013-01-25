package core {
	public class Time {
		public var delta:Number;
		
		public function Time(num:Number) {
			delta = num;
		}
		
		public function toString() : String {
			return "Elapsed: " + delta;
		}
	}
}