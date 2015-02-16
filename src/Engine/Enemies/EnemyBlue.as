package src.Engine.Enemies{	
	import src.Engine.Engine;
	import flash.filters.DropShadowFilter;
	import flash.display.MovieClip;
	
	public class EnemyBlue extends Enemy{

		var bgmc:MovieClip = new MovieClip();
		var inc:Boolean = true;
		
		public function EnemyBlue (e:MovieClip, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			frame = Math.random() * 12;
			addChild(bgmc);
			maxSpeed *= 1.5;
			maxHealth *= 0.75;
			health *= 0.75;
			beginClass();
		}
		
		override public function slow(){
			if(slowings == 0) maxSpeed *= 0.75;
			slowings++;
		}
		override public function unslow(){
			slowings--;
			if(slowings == 0) maxSpeed *= (4/3);
		}
		
		override public function radar(_r:Number){
			_r = 1 + (_r-1) * 0.5;
			if (radared < _r){
				radared = _r;
				objective.alpha = 0.8;
			}
			addChild(objective);
		}
		
		var ff:Number;
		override protected function drawMe(){			
			ff = frame/40;
			
			graphics.lineStyle(2,0x0000FF);
			if(xSpeed > 0){
				gotoAndStop(1);
				scaleX = 0.8 + ff;				
			}				
			else if (xSpeed < 0){
				gotoAndStop(3);
				scaleX = 0.8 + ff;
			}				
			else if (ySpeed > 0){
				gotoAndStop(2);
				scaleY = 0.8 + ff;				
			}
			else if (ySpeed < 0){
				gotoAndStop(4);
				scaleY = 0.8 + ff;				
			}
			life.scaleX = 1/scaleX;
    		life.scaleY = 1/scaleY;
		}
	
	
		override protected function countFrames(){
			if(inc) frame++;
			else frame--;
			if(frame>=12 || frame <= 0) inc = !inc;
			
		}
	}
}
