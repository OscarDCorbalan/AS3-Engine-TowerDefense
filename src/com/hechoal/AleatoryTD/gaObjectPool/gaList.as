/**
 * This contains an ordered list of objects.
 *
 * Traversal example:
 *		var node:gaListNode = list.head, item:ObjType;
 		for(; node != null; node = node.next) {
 			item = ObjType(node.data);
 			// code...
 		}
 **/
package com.hechoal.AleatoryTD.gaObjectPool {
	import flash.system.Security;
	public class gaList {
		function gaList(a:Array = null) {
			if(_pool == null)
				_pool = new gaListNodePool(10);
			if(a != null)
				fromArray(a);
		}
		
		/**
		 * Interface
		 **/
		 
		// Adds an object to the end of the list.
		public function add(obj:Object):gaListNode {
			var node:gaListNode = _pool.getNode();
			node.data = obj;
			if(head == null) {
				head = tail = node;
			}
			else {
				tail.next = node;
				node.prev = tail;
				tail = node;
			}
			_count++;
			return node;
		}
		
		// Adds an object at the head of the list.
		public function addHead(obj:Object):gaListNode {
			var node:gaListNode = _pool.getNode();
			node.data = obj;
			if(head == null) {
				head = tail = node;
			}
			else {
				node.next = head;
				head.prev = node;
				head = node;
			}
			_count++;
			return node;
		}
		
		// Adds the items of the specified list to the end of this list.
		public function addRange(list:gaList):void {
			var node:gaListNode = list.head;
			for(; node != null; node = node.next) {
				add(node.data);
			}
		}
		
		// Removes the items in list from this list.
		public function removeRange(list:gaList):void {
			var node:gaListNode = list.head;
			for(; node != null; node = node.next) {
				remove(node.data);
			}
		}

		// Removes the specified object from the list.  If the object was found, then
		// the method returns true, otherwise false.
		public function remove(obj:Object):Boolean {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data == obj) {
					removeNode(node);
					return true;
				}
			}
			return false;
		}
		
		// Find the list node which contains obj.
		public function findNode(obj:Object):gaListNode {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data == obj)
					return node;
			}
			return null;
		}
		
		// Returns true if the list contains obj.
		public function contains(obj:Object):Boolean {
			return findNode(obj) != null;
		}
		
		// Inserts obj into the list in sorted order, using compareFunc as the callback for determining order.
		// function compareFunc(a, b):Number, where compareFunc returns <0 if a < b, >0 if a > b, and 0 if a == b.
		public function insert(obj:Object, compareFunc:Function):gaListNode {
			if(_count == 0 || compareFunc(obj, tail.data) > 0) {
				add(obj);
				return tail;
			}
			else {
				var node:gaListNode = head;
				while(node != null && compareFunc(obj, node.data) > 0)
					node = node.next;
				
				if(node == null)
					trace("*** gaList.insert, should have added to the tail but didn't");
				var objNode:gaListNode = _pool.getNode();
				objNode.data = obj;
				objNode.next = node;
				objNode.prev = node.prev;
				node.prev = objNode;
				if(objNode.prev != null)
					objNode.prev.next = objNode;
				if(node == head)
					head = objNode;
				_count++;
				return objNode;
			}
			return null;
		}
		
		// Removes and returns the first item in the list.
		public function removeHead():Object {
			if(head != null) {
				var node:gaListNode = head;
				head = head.next;
				if(head != null)
					head.prev = null;
				else
					tail = null;
				var ret:Object = node.data;
				_pool.returnNode(node);
				_count--;
				return ret;
			}
			return null;
		}
		
		// Removes and returns the last item in the list.
		public function removeTail():Object {
			if(head != null) {
				var node:gaListNode = tail;
				tail = tail.prev;
				if(tail != null)
					tail.next = null;
				else
					head = null;
				var ret:Object = node.data;
				_pool.returnNode(node);
				_count--;
				return ret;
			}
			return null;
		}

		// Removes the specified node from the list.
		public function removeNode(node:gaListNode):void {
			if(node.prev != null)
				node.prev.next = node.next;
			if(node.next != null)
				node.next.prev = node.prev;
			if(node == head)
				head = node.next;
			if(node == tail)
				tail = node.prev;
			_pool.returnNode(node);
			_count--;
		}
		
		// Returns a random node from the list.
		public function getRandomNode():gaListNode {
			trace("HERE");
			var idx:int = Math.floor(Math.random() * _count), 
				i:int = 0, 
				node:gaListNode = head;
			return node;/*
			for(; node != null && i < idx; node = node.next, i++)
				; // Nothing needed here
			return node;*/
		}
		
		// Removes and returns a random object from the list.
		public function removeRandom():Object {
			var node:gaListNode = getRandomNode();
			var ret:Object = node.data;
			removeNode(node);
			return ret;
		}

		// Moves the object at the head of the list to the end of the list, and returns the object moved.
		public function rotateHead():Object {
			if(head != null) {
				var obj:Object = head.data;
				if(head != tail) {
					var node:gaListNode = head;
					head = head.next;
					if(head != null)
						head.prev = null;
					tail.next = node;
					node.next = null;
					node.prev = tail;
					tail = node;
				}
				return obj;
			}
			return null;
		}

		// Moves the object at the end of the list to the head of the list, and returns the object moved.
		public function rotateTail():Object {
			if(tail != null) {
				var obj:Object = tail.data;
				if(head != tail) {
					var node:gaListNode = tail;
					tail = tail.prev;
					if(tail != null)
						tail.next = null;
					head.prev = node;
					node.prev = null;
					node.next = head;
					head = node;
				}
			}
			return null;
		}
		
		// Returns the number of items in the list.
		public function getCount():int {
			return _count;
		}

		// Returns the first item in the list.
		public function getFirst():Object {
			if(head != null)
				return head.data;
			return null;
		}

		// Returns the last item in the list.
		public function getLast():Object {
			if(tail != null)
				return tail.data;
			return null;
		}

		// Returns a random object in the list.
		public function getRandom():Object {
			var node:gaListNode = getRandomNode();
			return node.data;
		}

		// Reverses the order of the items in the list.
		public function reverse():void {
			if(_count > 1) {
				var newTail:gaListNode = head, newHead:gaListNode = tail, src:gaListNode = tail.prev, dst:gaListNode = tail, temp:gaListNode;
				newHead.next = null;
				newHead.prev = null;
				while(src != null) {
					temp = src.prev;
					dst.next = src;
					src.next = null;
					src.prev = dst;
					dst = src;
					src = temp;
				}
				head = newHead;
				tail = newTail;
			}
		}
		
		// Creates a new list (optionally based on a list pool, if you want to pool gaList objects), and
		// adds all items in this list to the new one.
		public function clone(pool:gaObjectPool = null):gaList {
			var newList:gaList;
			if(pool != null)
				newList = gaList(pool.getObj());
			else
				newList = createNewList();
			apply0(newList.add);
			return newList;
		}
		
		// Creates a new list which contains all items in THIS list followed by all the items in other.
		public function concat(other:gaList):gaList {
			var newList:gaList = clone();
			other.apply0(newList.add);
			return newList;
		}
		
		// Uses a merge sort (pretty fast) to sort the items in the list according to the specified compareFunc (same compareFunc as insert).
		public function sort(compareFunc:Function):gaList {
			var p:gaListNode, q:gaListNode, e:gaListNode;
			var insize:int = 1, nmerges:int, psize:int, qsize:int, i:int;
			if(_count < 2)
				return this;
			while(true) {
				p = head;
				head = null;
				tail = null;
				nmerges = 0; // count number of merges we do in this pass
				while(p != null) {
					nmerges++;
					// Step 'insize' places along from p
					q = p;
					psize = 0;
					for(i = 0; i < insize; i++) {
						psize++;
						q = q.next;
						if(!q)
							break;
					}

					// If q hasn't fallen off the end, we have 2 lists to merge
					qsize = insize;

					// We have 2 lists, so merge them
					while(psize > 0 || (qsize > 0 && q != null)) {
						// Decide whether next element comes from p or q
						if(psize == 0) {
							// p is empty, so take from q
							e = q;
							q = q.next;
							qsize--;
						}
						else if(qsize == 0 || q == null) {
							// q is empty, so take from p
							e = p;
							p = p.next;
							psize--;
						}
						else if(compareFunc(p.data, q.data) <= 0) {
							// First element of p is lower, so take from p
							e = p;
							p = p.next;
							psize--;
						}
						else {
							// First element of q is lower, so take from q
							e = q;
							q = q.next;
							qsize--;
						}

						// Add next element to merged list
						if(tail != null)
							tail.next = e;
						else
							head = e;
						e.prev = tail;
						tail = e;
					}

					p = q;
				}

				tail.next = null;

				if(nmerges <= 1)
					break;

				insize *= 2;
			}
			return this;
		}
		
		// Removes all items from the list.
		public function clear():void {
			while(head != null) {
				var temp:gaListNode = head;
				head = head.next;
				_pool.returnNode(temp);
			}
			tail = null;
			_count = 0;
		}
		
		/**
		 * runX - These methods invoke a method on each item in the list
		 * with X parameters.
		 **/
		
		public function run0(funcName:String):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				node.data[funcName]();
			}
		}
		
		public function run1(funcName:String, arg1:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				node.data[funcName](arg1);
			}
		}
		
		public function run2(funcName:String, arg1:Object, arg2:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				node.data[funcName](arg1, arg2);
			}
		}
		
		public function run3(funcName:String, arg1:Object, arg2:Object, arg3:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				node.data[funcName](arg1, arg2, arg3);
			}
		}
		
		/**
		 * testAnyX - These methods invoke a method on each item and returns
		 * the first item for which the method return value is true.
		 **/
		
		public function testAny0(funcName:String):Object {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName]())
					return node.data;
			}
			return null;
		}
		
		public function testAny1(funcName:String, arg1:Object):Object {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1))
					return node.data;
			}
			return null;
		}
		
		public function testAny2(funcName:String, arg1:Object, arg2:Object):Object {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1, arg2))
					return node.data;
			}
			return null;
		}
		
		public function testAny3(funcName:String, arg1:Object, arg2:Object, arg3:Object):Object {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1, arg2, arg3))
					return node.data;
			}
			return null;
		}
		
		/**
		 * testAllX - These methods invoke a method on each item and builds a
		 * new gaList that contains all items for which that method returned
		 * true.
		 **/
		
		public function testAll0(funcName:String, pool:gaObjectPool = null):gaList {
			var list:gaList = createNewList(pool);
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName]())
					list.add(node.data);
			}
			return list;
		}
		
		public function testAll1(funcName:String, arg1:Object, pool:gaObjectPool = null):gaList {
			var list:gaList = createNewList(pool);
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1))
					list.add(node.data);
			}
			return list;
		}
		
		public function testAll2(funcName:String, arg1:Object, arg2:Object, pool:gaObjectPool = null):gaList {
			var list:gaList = createNewList(pool);
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1, arg2))
					list.add(node.data);
			}
			return list;
		}
		
		public function testAll3(funcName:String, arg1:Object, arg2:Object, arg3:Object, pool:gaObjectPool = null):gaList {
			var list:gaList = createNewList(pool);
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				if(node.data[funcName](arg1, arg2, arg3))
					list.add(node.data);
			}
			return list;
		}
		
		/**
		 * applyX - These methods apply an external function to each item in the list.
		 * The item is supplied as the first parameter to the function, and then all
		 * subsequent parameters are passed in the order they are given to the applyX
		 * method.
		 **/
		
		public function apply0(func:Function):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				func(node.data);
			}
		}
		
		public function apply1(func:Function, arg1:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				func(node.data, arg1);
			}
		}
		
		public function apply2(func:Function, arg1:Object, arg2:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				func(node.data, arg1, arg2);
			}
		}
		
		public function apply3(func:Function, arg1:Object, arg2:Object, arg3:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				func(node.data, arg1, arg2, arg3);
			}
		}
		
		public function apply4(func:Function, arg1:Object, arg2:Object, arg3:Object, arg4:Object):void {
			var node:gaListNode = head;
			for(; node != null; node = node.next) {
				func(node.data, arg1, arg2, arg3, arg4);
			}
		}

		public function sum0(funcName:String):int {
			var node:gaListNode = head, total:int = 0;
			for(; node != null; node = node.next) {
				total += node.data[funcName]();
			}
			return total;
		}
		
		public function toArray():Array {
			var a:Array = new Array(_count), i:int = 0, node:gaListNode = head;
			for(; node != null; node = node.next, i++) {
				a[i] = node.data;
			}
			return a;
		}

		public function fromArray(a:Array):void {
			clear();
			for(var len:int = a.length, i:int = 0; i < len; i++) {
				add(a[i]);
			}
		}
		
		public function dump():void {
			var node:gaListNode = head, i:int = 0;
			for(; node != null; node = node.next, i++) {
				trace("list[" + i + "] = " + node.data);
			}
		}
		
		/**
		 * Implementation
		 **/

		private static var _pool:gaListNodePool = null;
		
		public var head:gaListNode = null, tail:gaListNode = null;
		private var _count:int = 0;

		protected function createNewList(pool:gaObjectPool = null):gaList {
			if(pool != null)
				return gaList(pool.getObj());
			return new gaList();
		}
	}
}
