package src.Engine {	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import src.ObjectPool.ObjectPool;


	public class Particle extends Sprite
	{		
		private var sx:Number;
		private var sy:Number;
		private var r:Number;
		private var count:uint;
		private var _init:uint;
		private var pool:ObjectPool;
		
		public function Particle()
		{
			
			r = Math.random() * 360;
			_init = Math.random() * 20;
		}
				
		public function init(xx:Number, yy:Number, color:uint, po:ObjectPool){
			sx = xx;
			sy = yy;	
			pool = po;
			count = _init;
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, 1);
			addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void
		{
			count++;
			alpha = 1 - count/30;

			x = sx + Math.cos(r) * count;
			y = sy + Math.sin(r) * count;
			
			// loop star when it goes off the stage.
			if (count == 30){
				removeEventListener(Event.ENTER_FRAME, update);
				destroy();
			}
		}	
		
		private function destroy(){
			graphics.clear();
			MovieClip(parent).removeChild(this);
			pool.returnObj(this);
		}
 
	}
 

}