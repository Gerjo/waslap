package datacontainer {

	public class LinkedList {
		public var head:Node = null;
		public var tail:Node = null;
		private var _length:int = 0;
		
		public function LinkedList() {
			
		}
		
		public function get length():int {
			return _length;
		}
		
		public function foreach(callback:Function, doHeadToTail:Boolean = true) : void {
			var node:Node;
			
			if(doHeadToTail) {
				node = head;
				
				while (node != null) {
					callback(node.nodeData);
					node = node.nextNode;
				}
			} else {
				node = tail;
				
				while (node != null) {
					callback(node.nodeData);
					node = node.previousNode;
				}
			}
		}
		
		public function insertHead(item:*) : void {
			var node:Node     = new Node(item);
			node.nextNode     = head;
			
			if(head != null) {
				head.previousNode = node;
			}
			
			head = node;
			
			if (tail == null) {
				tail = head;
			}
			
			++_length;
		}

		public function popTail() : * {
			if (tail == null) {
				throw new Error("Nico: you cannot pop when empty.");
			}
			
			var data:* = tail.nodeData;
			
			tail = tail.previousNode;
			tail.nextNode = null;
			
			--_length;
			
			return data;
		}
	}
}