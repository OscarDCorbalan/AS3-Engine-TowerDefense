package src.ObjectPool {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class OPListNodePool {
		function OPListNodePool(blockSize:int) {
			_blockSize = blockSize;
			allocateBlock();
		}

		/**
		 * Interface
		 **/

		public function getNode():OPListNode {
			if(_head == null)
				allocateBlock();
			var temp:OPListNode = _head;
			_head = temp.next;
			temp.next = null;
			if(temp.allocated)
				trace("OPListNodePool.getNode, re-allocating node!");
			temp.allocated = true;
			return temp;
		}

		public function returnNode(node:OPListNode):void {
			node.next = node.prev = null;
			node.data = null;
			if(!node.allocated)
				trace("OPListNodePool.returnNode, returning an unallocated node!");
			node.allocated = false;
			node.next = _head;
			_head = node;
		}

		/**
		 * Implementation
		 **/

		private var _head:OPListNode = null, _blockSize:int;

		private function allocateBlock():void {
			for(var i:int = 0; i < _blockSize; i++)
				returnNode(new OPListNode());
		}
	}
}
