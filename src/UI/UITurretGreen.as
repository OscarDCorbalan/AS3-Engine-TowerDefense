package src.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.Engine.Engine;
	
	
	public class UITurretGreen extends UITurret {
		
		
		public function UITurretGreen(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTGreen);
			type = _green;
			overFun = ui.overTGreen;
		}
	
		public function getText(){
			return statsToString()
			 	+"\nA self-guided weapon can reach distant"
				+"\nenemies to deliver explosive charges."
				+"\nThe depot can have up to 9 launchers.";	
		}			

	}
}