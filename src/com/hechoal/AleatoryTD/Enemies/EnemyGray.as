package com.hechoal.AleatoryTD.Enemies{
	import com.hechoal.AleatoryTD.Engine;
	
	public class EnemyGray extends Enemy{

		var inc:Boolean = true;
		
		public function EnemyGray(e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			frame = 12*Math.random();
			drawMe();
			beginClass();
		}
		
		override protected function drawMe(){			
			graphics.beginFill(0xCCCCCC, 0.6-frame/24); 
			graphics.lineStyle(1, 0xBBBBBB);
			graphics.drawCircle(12.5,12.5,2+frame/5);	
			graphics.endFill();
		}
		
		override protected function countFrames(){
			if(inc) frame++;
			else frame--;
			if(frame>=12 || frame <= 0) inc = !inc;
		}

	}
	
}
