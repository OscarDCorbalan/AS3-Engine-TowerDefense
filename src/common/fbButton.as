package src.common{
	
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class fbButton extends MovieClip{
		
		
		public function fbButton(xx:uint, yy:uint) {
			x = xx;
			y = yy;
		}		

		public function makeButton(clickFunction:Function):void {
			addEventListener(MouseEvent.CLICK, clickFunction);	
		}
		
	}
	
}
