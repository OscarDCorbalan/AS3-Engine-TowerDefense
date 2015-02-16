package src.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.Engine.Engine;
	
	
	public class UITurretRed extends UITurret {
		
		
		public function UITurretRed(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTRed);//adding function for mouseOver
			type = _red;
			overFun = ui.overTRed;
		}
		
		public function getText(){
			return statsToString()
			 	+"\nA train of brief pulses of light causes"
				+"\nshockwaves that damage the target."
				+"\nAn array can power up to four lasers.";																																
		
			//return "Price: "+price+"\tA laser is a beam of\nDamage: "+dmg+"\tenergy focused on a\nRange: "+rng+"\tsingle point that causes\n\t\t\t\tconstant damage.\nA facility can fire up to four lasers.";																																
		}
	}
}