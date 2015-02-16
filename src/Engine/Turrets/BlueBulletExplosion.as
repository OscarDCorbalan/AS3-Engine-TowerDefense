package src.Engine.Turrets {
	import src.Engine.Engine;
	import flash.display.MovieClip;
	import flash.events.Event;
	import src.Engine.Enemies.*;
	import flash.filters.DropShadowFilter;

	public class BlueBulletExplosion extends MovieClip{
		
		private var num:uint;
		private var i:uint;
		private var j:uint;
		private var count:uint = 0;
		private var damage:Number;	
		private const sec:uint = 24;
		var targets:Array = new Array();
		
		public function BlueBulletExplosion(e:Engine, n:uint, t:Enemy, d:uint) {
			num = n;
			damage = d/sec;
			
			var cEnemy;			
			var di:uint = 60;
			targets.push(t);
			for(i = 0; i < e.enemyHolder.numChildren; i++){
				cEnemy = e.enemyHolder.getChildAt(i);
				if(t != cEnemy){
					if(	t.x+di > cEnemy.x && t.x-di < cEnemy.x
					 &&t.y+di > cEnemy.y && t.y-di < cEnemy.y)
					{
						targets.push(cEnemy);
					}				
				}
			}
			targets = targets.slice(0, num);
			var dropShadow:DropShadowFilter = new DropShadowFilter();

			dropShadow.color = 0x0000FF;
			dropShadow.blurX = 7;			
			dropShadow.blurY = 7;			
			dropShadow.angle = 0;			
			dropShadow.alpha = 1;			
			dropShadow.distance = 0;
			var filtersArray:Array = new Array(dropShadow);			
			filters = filtersArray;
			mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME,eFrame);			
		}

		var r1:Number,
			r2:Number,
			k:uint;
		private function eFrame(e:Event):void {			
			count++;			
			graphics.clear();
			
			graphics.lineStyle();
			graphics.beginFill(0xFF,Math.random()*0.5);
			graphics.drawCircle(targets[0].x+12.5, targets[0].y+12.5, sec - count);
			graphics.endFill();
			
			graphics.lineStyle(2,0x4040FF, Math.random());
			for(i = 0; i < targets.length; i++){		
				if(targets[i].health>0){
					if(targets[i] is EnemyBlue){
						targets[i].health -= damage * 0.5 * targets[i].radared;		
					}
					else if(targets[i] is EnemyCyan || targets[i] is EnemyMagenta){
						targets[i].health -= damage * 0.75 * targets[i].radared;		
					}
					else
						targets[i].health -= damage * targets[i].radared;		
					for(j = i+1; j < targets.length; j++){
						if(targets[j].health>0){
							r1 = -15 + (25 + targets[j].x + targets[i].x) /2;
							r2 = -15 + (25 + targets[j].y + targets[i].y) /2;
											
							graphics.moveTo(targets[i].x+12.5, targets[i].y+12.5);
							graphics.curveTo(r1 + Math.random()*30,
											 r2 + Math.random()*30,
											 targets[j].x+12.5, targets[j].y+12.5);
						}
					}
				}
			}
			
			if(count == sec){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
			}
		}
		
		private function destroyThis(){
			for(i = 0; i < targets.length; i++){
				targets[i] = null;
			}
			targets = null;			
			MovieClip(parent).removeChild(this);
		}

	}
	
}
