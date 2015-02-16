package src.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.Engine.Engine;
	
	
	public class UITurretBlue extends UITurret {
		
		
		public function UITurretBlue(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTBlue);
			type = _blue;
			overFun = ui.overTBlue;
		}
		
		public function getText(){
			return statsToString()
			 	+"\nFiring a proton with enough energy"
				+"\ncauses a quantum singularity on the"
				+"\nhit zone that damages near enemies.";		
			//return "Price: "+price+"\tThe particle accelerator\nDamage: "+dmg+"\tthrow atoms with so much\nRange: "+rng+"\tenergy that can alter \n\t\t\t\the space-time.";
		  //return "Price: "+price+"\tA laser is a beam of\nDamage: "+dmg+"\t energy focused on a\nRange: "+rng+"\tsingle point that causes\n\t\t\t\tconstant damage.\nA facility can fire up to four lasers.";																																
		}
	}
}