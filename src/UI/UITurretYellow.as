package src.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.Engine.Engine;
	
	
	public class UITurretYellow extends UITurret {
		
		
		public function UITurretYellow(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTYellow);
			type = _yellow;
			overFun = ui.overTYellow;
		}

		public function getText(){
			return statsToString()
				+"\nA pair of parallel conducting rails"
				+"\ncan accelerate an electromagnetic"
				+"\nprojectile to very dangerous speeds.";
		}
	}
}