package src.Engine.Enemies{
	import src.Engine.Engine;

	public class EnemyMagenta extends Enemy{

		public function EnemyMagenta (e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			var ff:uint = Math.random() * 30;
			this.gotoAndPlay(ff);
			beginClass();
		}
		
		override public function radar(_r:Number){
			return;
		}
		override public function unradar(){
			return;
		}
		
	}
	
}
