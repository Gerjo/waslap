package datacontainer {
	public class Node {
		public var nodeData:*;
		public var nextNode:Node = null;
		public var previousNode:Node = null;
		
		public function Node(nodeData:*) {
			this.nodeData = nodeData;
		}
		
		public function getData():* {
			return nodeData;
		}
		
		public function insertPrevious(node:Node):void {
			node.nextNode = this;
		}
		
		public function insertNext(node:Node):void {
			nextNode = node;
		}
		
		public function getNext():Node {
			return nextNode;
		}
	}
}