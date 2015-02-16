package src.ObjectPool {
	import flash.display.MovieClip;
	
	public class ObjectPool {
		function ObjectPool(objClass:Class, blockSize:int) {
			_class = objClass;
			_blockSize = blockSize;
			_objs = new OPList();
			allocateBlock();
		}

		/**
		 * Interface
		 **/

		// Call this to get an object from the pool.  Just cast it to whatever it is.
		public function getObj():Object {
			if(_objs.head == null)
				allocateBlock();
			return _objs.removeHead();
		}

		// Call this to return the no-longer-needed object to the pool, so someone else can use it later.
		public function returnObj(obj:Object):void {
			_objs.add(obj);
		}

		// This deallocates objects until only blockSize objs remain.
		public function clean():void {
			while(_objs.getCount() > _blockSize)
				_objs.removeHead();
		}

		public function destroy():void {
			_objs.clear();
		}

		/**
		 * Implementation
		 **/

		private var _class:Class, _blockSize:int, _objs:OPList;

		private function allocateBlock():void {
			for(var i:int = 0; i < _blockSize; i++) {
				var obj:Object = new _class();
				if(obj is MovieClip)
					obj.gotoAndStop(1);
				_objs.add(obj);
			}
		}
	}
}
