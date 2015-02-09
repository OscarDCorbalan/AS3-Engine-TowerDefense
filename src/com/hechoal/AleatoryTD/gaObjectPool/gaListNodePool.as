/**
 * 
 **/
package com.hechoal.AleatoryTD.gaObjectPool {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class gaListNodePool {
		function gaListNodePool(blockSize:int) {
			_blockSize = blockSize;
			allocateBlock();
		}

		/**
		 * Interface
		 **/

		public function getNode():gaListNode {
			if(_head == null)
				allocateBlock();
			var temp:gaListNode = _head;
			_head = temp.next;
			temp.next = null;
			if(temp.allocated)
				trace("gaListNodePool.getNode, re-allocating node!");
			temp.allocated = true;
			return temp;
		}

		public function returnNode(node:gaListNode):void {
			node.next = node.prev = null;
			node.data = null;
			if(!node.allocated)
				trace("gaListNodePool.returnNode, returning an unallocated node!");
			node.allocated = false;
			node.next = _head;
			_head = node;
		}

		/**
		 * Implementation
		 **/

		private var _head:gaListNode = null, _blockSize:int;

		private function allocateBlock():void {
			for(var i:int = 0; i < _blockSize; i++)
				returnNode(new gaListNode());
		}
	}
}
