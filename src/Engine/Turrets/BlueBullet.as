package src.Engine.Turrets{
	import flash.display.MovieClip;
	import flash.events.*;
	import src.Engine.Engine;
	import src.Engine.Enemies.Enemy;
	import flash.filters.DropShadowFilter;
	
	public class BlueBullet extends MovieClip {
		protected var target;
		protected var damage:uint;
		protected var num:uint;
		
		public function BlueBullet(t:Enemy, d:uint, n:uint) {
			target = t;
			damage = d;
			num = n+1;
			mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME,eFrame);
		}

		
		var count:uint = 0;

		private function eFrame(e:Event):void {
			count ++;
			graphics.clear();
			graphics.lineStyle(count/2, 0x0000FF);
			graphics.moveTo(0,0); ///This is where we start drawing
			graphics.lineTo(target.x+12.5 - x , target.y+12.5 - y );
			
			
			if(count == 10){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis(true);
			}
			else if(target.health <= 0){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis(false);
			}
		}
		
		public function destroyThis(expand:Boolean):void{			
			if(expand) 
				MovieClip(parent).addChild(new BlueBulletExplosion(Engine(parent), num, target, damage));
			MovieClip(parent).removeChild(this);
			target = null;
		}
	}
}