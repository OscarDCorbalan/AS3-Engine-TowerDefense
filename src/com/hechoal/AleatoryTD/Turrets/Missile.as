package  com.hechoal.AleatoryTD.Turrets{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.filters.DropShadowFilter;
	import com.hechoal.AleatoryTD.gaObjectPool.gaObjectPool;
	
	public class Missile extends Sprite {
		protected var target;
		protected var damage:uint;
		protected var pool:gaObjectPool;
		protected var poolT:gaObjectPool;
		protected var count:uint;
		const maxSpeed:uint = 6;		
		
		public function Missile() {			
			mouseEnabled = false;
		}
		
		public function init(t:Enemy, d:uint, po:gaObjectPool, pt:gaObjectPool){			
			target = t;
			damage = d;
		
			pool = po;
			poolT = pt;
			count = 0;
			graphics.beginFill(0x00FF00);
			graphics.drawCircle(0,0,2);
			graphics.endFill();		
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
		
		var yDist:Number,
			xDist:Number,
			xSpeed:Number,
			ySpeed:Number,
			angle:Number,
			_mt:MissileTrack;
		private function eFrame(e:Event):void {

			if(target.health <= 0){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
				return;
			}
			
			yDist = target.y +12.5 - y;
			xDist = target.x +12.5 - x;
			angle = Math.atan2(yDist,xDist);
			
			ySpeed=Math.sin(angle) * maxSpeed;
			xSpeed=Math.cos(angle) * maxSpeed;
			x += xSpeed;
			y += ySpeed;
 
 			_mt = MissileTrack(poolT.getObj());
 			MovieClip(parent).addChild(_mt);
			_mt.init(x, y, poolT);
			
			if(hitTestObject(target)){
				if(target is EnemyGreen){
					target.health -= damage * 0.5 * target.radared;		
				}
				else if(target is EnemyCyan || target is EnemyYellow){
					target.health -= damage * 0.75 * target.radared;		
				}
				else
					target.health -= damage * target.radared;
				
				removeEventListener(Event.ENTER_FRAME, eFrame);
				addEventListener(Event.ENTER_FRAME, eFrameExplosion);
			}
			
		}
		
		private function eFrameExplosion(e:Event):void {
			count++;
			graphics.clear();
			graphics.lineStyle(1,0x00FF00, 0.75)
			graphics.drawCircle(0,0,count);
			
			if(count == 5){
				removeEventListener(Event.ENTER_FRAME, eFrameExplosion);
				destroyThis();
			}
		}
		public function destroyThis():void{		
			graphics.clear();
			MovieClip(parent).removeChild(this);			
			target = null;
			pool.returnObj(this);
			pool=null;
			_mt = null;
		}
	}
}