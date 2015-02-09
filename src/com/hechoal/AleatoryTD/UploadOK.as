package com.hechoal.AleatoryTD {
	import flash.events.*;
	import flash.display.MovieClip;

	public class UploadOK extends MovieClip{
		private var frames:uint;
		private var count:uint;
		
		public function UploadOK(_f:uint) {
			count = 0;
			frames = _f;
			addEventListener(Event.ENTER_FRAME, ef);
		}
		
		private function ef(e:Event){
			count++;
			if(count >= frames){
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, ef);
			}
		}
		
		

	}
	
}
