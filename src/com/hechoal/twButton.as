package com.hechoal {
	
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class twButton extends MovieClip{
		
		
		public function twButton(xx:uint, yy:uint) {
			x = xx;
			y = yy;
		}		

		public function makeButton(clickFunction:Function):void {
			addEventListener(MouseEvent.CLICK, clickFunction);	
		}
		
	}
	
}
