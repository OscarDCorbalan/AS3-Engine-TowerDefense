package  com.hechoal.AleatoryTD.Turrets{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.filters.DropShadowFilter;
	import com.hechoal.AleatoryTD.gaObjectPool.*;
	
	public class Ray extends Sprite {
		private var count:Number;
		private var pool:gaObjectPool;
		
		public function Ray() {			
			/*var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color = 0xFF00FF;			
			dropShadow.blurX = 3;			
			dropShadow.blurY = 3;			
			dropShadow.angle = 0;			
			dropShadow.alpha = 1;			
			dropShadow.distance = 0;
			var filtersArray:Array = new Array(dropShadow);			
			filters = filtersArray;	*/
			mouseEnabled = false;
		}

		public function init(xx:Number, yy:Number, po:gaObjectPool){//, _r:uint){
			pool = po;
			count = 0;
			graphics.lineStyle(1, 0xff00ff);
			graphics.moveTo(0,0);
			graphics.lineTo(xx , yy );
			//graphics.drawCircle(0,0,_r);
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
		
		private function eFrame(e:Event):void {
			count ++;
			
			alpha = 0.75 - count/12;

			if(count==9){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
			}
		}
		
		public function destroyThis():void{
			graphics.clear();
			MovieClip(parent).removeChild(this);
			pool.returnObj(this);
			pool = null;
		}
	}
}