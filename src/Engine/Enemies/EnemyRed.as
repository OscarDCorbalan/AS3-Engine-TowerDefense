package src.Engine.Enemies{
	import src.Engine.Engine;
	
	public class EnemyRed extends Enemy{

		var inc:Boolean = true;
		
		public function EnemyRed(e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			frame = 12*Math.random();
			var ff:uint = Math.random() * 30;
			gotoAndPlay(ff);
			beginClass();
			maxSpeed *= 0.75;
			maxHealth *= 1.3;
			health *= 1.3;
		}
		
		override public function radar(_r:Number){
			_r = 1 + (_r-1) * 0.5;
			if (radared < _r){
				radared = _r;
				objective.alpha = 0.8;
			}
			addChild(objective);
		}
		
		override protected function drawMe(){
		}

		
	}
	
}
