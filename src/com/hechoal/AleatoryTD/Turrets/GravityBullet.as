package  com.hechoal.AleatoryTD.Turrets{
	import flash.display.MovieClip;
	import flash.events.*;
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.filters.DropShadowFilter;
	import com.hechoal.AleatoryTD.gaObjectPool.gaObjectPool;
	
	public class GravityBullet extends MovieClip {
		
		protected var target:Enemy;
		protected var pool:gaObjectPool;
		protected var damage:uint;
		protected var damage50:uint;
		protected var damage75:uint;
		protected var slow:Number;
		protected var xt:Number;
		protected var yt:Number;
		var count:uint;
		
		public function GravityBullet() {			
			/*var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color = 0x00FFFF;			
			dropShadow.blurX = 20;			
			dropShadow.blurY = 20;			
			dropShadow.angle = 0;			
			dropShadow.alpha = 1;			
			dropShadow.distance = 0;
			var filtersArray:Array = new Array(dropShadow);			
			filters = filtersArray;*/
			mouseEnabled = false;
			
		}
		
		public function init(xx:Number, yy:Number, t:Enemy, d:uint, po:gaObjectPool) {
			xt=xx;
			yt=yy;
			target = t;
			damage = d/25;
			damage50 = damage * 0.5;
			damage75 = damage * 0.75;
			pool = po;
			target.slow();
			
			count = 0;		
			
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
		
		private function eFrame(e:Event):void {
			count ++;
			
			graphics.clear();
			graphics.lineStyle(3, 0x00FFFF,Math.random() * 0.5);
			graphics.moveTo(xt,yt);
			graphics.lineTo(target.x+12.5 , target.y+12.5 );

			graphics.lineStyle(1,0x00FFFF, Math.random());
			graphics.moveTo(target.x+4, target.y+8);
			graphics.lineTo(target.x+20,target.y+8);
			graphics.moveTo(target.x+8, target.y+4);
			graphics.lineTo(target.x+8,target.y+20);
			graphics.moveTo(target.x+4, target.y+16);
			graphics.lineTo(target.x+20,target.y+16);
			graphics.moveTo(target.x+16, target.y+4);
			graphics.lineTo(target.x+16,target.y+20);
			graphics.moveTo(target.x+4, target.y+12);
			graphics.lineTo(target.x+20,target.y+12);
			graphics.moveTo(target.x+12, target.y+4);
			graphics.lineTo(target.x+12,target.y+20);
			
			if(target is EnemyCyan){
				target.health -= damage50 * target.radared;		
			}
			else if(target is EnemyBlue || target is EnemyGreen){
				target.health -= damage75 * target.radared;		
			}
			else
				target.health -= damage * target.radared;
				
			if(count==25 || target.health <= 0){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
			}			

		}
		
		public function destroyThis(unslow:Boolean = true):void{	
			graphics.clear();
			MovieClip(parent).removeChild(this);
			target.unslow();
			pool.returnObj(this);
			pool = null;
			target = null;
		}
	}
}