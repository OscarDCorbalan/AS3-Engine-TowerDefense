package src.Engine.Enemies{	
	import src.Engine.Engine;
	import flash.filters.DropShadowFilter;
	import flash.display.MovieClip;
	
	public class EnemyCyan extends Enemy{

		var bgmc:MovieClip = new MovieClip();
		
		public function EnemyCyan (e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			frame = Math.random() * 12;
			addChild(bgmc);
			var ff:uint = Math.random() * 36;
			this.gotoAndPlay(ff);
			beginClass();
		}
		
		override public function slow(){
			return;
		}
		override  public function unslow(){
			return;
		}
		
	}
}
