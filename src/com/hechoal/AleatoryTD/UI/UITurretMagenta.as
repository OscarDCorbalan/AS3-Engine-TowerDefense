package com.hechoal.AleatoryTD.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hechoal.AleatoryTD.Engine;
	
	
	public class UITurretMagenta extends UITurret {
		
		
		public function UITurretMagenta(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTMagenta);
			type = _magenta;
			overFun = ui.overTMagenta;
		}

		public function getText(){
			return statsToString()
				+"\nRadar is an object-detection system."
				+"\nEnemies in radar range get more damage.";
				+"\nNeighbour turrets gain 10% range."
				
		}
	}
}