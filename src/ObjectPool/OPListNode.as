package src.ObjectPool {

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class OPListNode {
		function OPListNode() {
		}

		/**
		 * Interface
		 **/

		public var next:OPListNode = null;
		public var prev:OPListNode = null;

		public var data:* = null;

		public var allocated:Boolean = true;

		/**
		 * Implementation
		 **/
	}
}
