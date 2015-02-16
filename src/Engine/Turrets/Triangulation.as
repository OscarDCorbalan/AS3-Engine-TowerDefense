package src.Engine.Turrets {
	import src.Engine.Enemies.Enemy;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import src.ObjectPool.ObjectPool;
	
	public class Triangulation extends Sprite {
		private var count:Number = 0;
		private var objx:Number;
		private var objy:Number;
		private var pool:ObjectPool;
		
		public function Triangulation() {
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color = 0xFF0000;			
			dropShadow.blurX = 10;			
			dropShadow.blurY = 10;			
			dropShadow.angle = 0;			
			dropShadow.alpha = 1;			
			dropShadow.distance = 0;
			var filtersArray:Array = new Array(dropShadow);			
			filters = filtersArray;
			mouseEnabled = false;
		}
		
		public function init(xx:int, yy:int, po:ObjectPool){
			pool = po;
			count = 0;
			objx = xx;
			objy = yy;
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
		
		private function eFrame(e:Event):void {
			count ++;
			
			alpha = 1 - count/20;
			
			graphics.clear();					
			graphics.lineStyle(4 - count/5, 0xFFFF00);
			graphics.moveTo(0,0);				
			graphics.lineTo(objx , objy );
			
			if(count==20){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
			}
		}
		
		public function destroyThis():void{
			MovieClip(parent).removeChild(this);
			pool.returnObj(this);
			pool = null;
		}

	}
	
}
