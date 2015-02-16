package src.Editor {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class AngleTD extends Sprite{		
		protected var type:uint;
		protected var map:MapEdit;
		public function AngleTD(_me:MapEdit) {
			map = _me;
			type = 0;
			fill(0x133937,0.3);
		}
		
		protected function fill(_c:uint, _a:Number){
			graphics.clear();
			graphics.lineStyle(1,0x28719B,1);
			graphics.beginFill(_c, _a);
			graphics.drawRect(0,0,25,25);
			graphics.endFill();			
		}
		
		public function getType():uint{
			return type;
		}
	}
	
}
