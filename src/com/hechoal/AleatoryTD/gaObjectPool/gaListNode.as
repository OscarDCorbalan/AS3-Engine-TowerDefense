/**
 * 
 **/
package com.hechoal.AleatoryTD.gaObjectPool {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class gaListNode {
		function gaListNode() {
		}

		/**
		 * Interface
		 **/

		public var next:gaListNode = null;
		public var prev:gaListNode = null;

		public var data:* = null;

		public var allocated:Boolean = true;

		/**
		 * Implementation
		 **/
	}
}
