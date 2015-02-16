package src.Engine.Enemies{
	import src.Engine.Engine;
	
	public class EnemyYellow extends Enemy{

		public function EnemyYellow (e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			var ff:uint = Math.random() * 30;
			gotoAndPlay(ff);
			beginClass();
			//maxSpeed = 1 + Math.random();
		}
		
		override protected function drawMe(){			
			//graphics.lineStyle(1, 0xFF0000);
			//graphics.drawCircle(12.5,12.5,2+frame/5);	
		}
		
		/*
		var inc:Boolean = true;
		override protected function countFrames(){
			if(inc) frame++;
			else frame--;
			if(frame>=120 || frame <= 0) inc = !inc;
			maxSpeed = 0.1 + frame/30;
		}*/
	}
	
}
