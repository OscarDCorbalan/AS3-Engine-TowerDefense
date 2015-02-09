package com.hechoal {
	
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class lgButton extends MovieClip{
		
		
		public function lgButton(xx:uint, yy:uint) {
			x = xx;
			y = yy;
		}		

		public function makeButton(clickFunction:Function):void {
			addEventListener(MouseEvent.CLICK, clickFunction);	
		}
		
	}
	
}
