package src.Engine.Turrets{
	import src.Engine.Engine;
	import flash.display.MovieClip;
	import flash.events.Event;
	import src.ObjectPool.ObjectPool;
	
	public class MissileTrack extends MovieClip{

		private var count:Number;
		var pool:ObjectPool;
		public function MissileTrack() {
			graphics.clear();
			graphics.lineStyle(0.5,0x00FF00)
			graphics.drawCircle(0,0,1);
			mouseEnabled = false;
		}
		
		public function init(xx:uint, yy:uint, po:ObjectPool){
			count = 0;
			x=xx;
			y=yy;
			pool = po;
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
							 
		private function eFrame(e:Event):void {
			count++;			
			alpha = 1 - count/20;
			
			if(count == 10){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				MovieClip(parent).removeChild(this);
				pool.returnObj(this);
				pool = null;
			}
		}

	}
	
}
