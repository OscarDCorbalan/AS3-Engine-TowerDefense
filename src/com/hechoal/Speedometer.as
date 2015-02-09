package com.hechoal  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Speedometer extends MovieClip{
		protected var fast:Boolean;
		protected const fslow:uint = 24;
		protected const ffast:uint = 48;
		
		public function Speedometer(xx:uint, yy:uint) {
			x=xx;
			y=yy;
			addEventListener(Event.ADDED_TO_STAGE,added, false, 0, true);
		}

		private function added(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,added);
			alpha = 0.5;
			fast = false;
			buttonMode = true;
			mouseEnabled = true;
			addEventListener(MouseEvent.CLICK,clicked, false, 0, true);
		}
		
		private function clicked(e:Event){
			if(fast){
				fast = false;
				alpha = 0.5;
				stage.frameRate = fslow;
			}
			else{
				fast = true;
				alpha = 1;
				stage.frameRate = ffast;
			}
			
		}
		
		public function destroy(){
			removeEventListener(Event.ADDED_TO_STAGE,clicked);
			stage.frameRate = fslow;
			parent.removeChild(this);
		}
	}
	
}
