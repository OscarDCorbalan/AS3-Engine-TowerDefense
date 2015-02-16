package src.Engine{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.ColorTransform;

	
	public class FinishBlock extends Sprite{//defining the class as EmptyBlock
		public var www:Array = new Array();
		
		public function FinishBlock(e:MovieClip){//this function will always run once EmptyBlock is called
			buttonMode = false;

			graphics.beginFill(0x110000, 0.2);
			graphics.drawRect(0,0,25,25);
			graphics.endFill();
			
		}
		public function destroy(){
			graphics.clear();
			MovieClip(parent).removeChild(this);
		}
		
	}
}