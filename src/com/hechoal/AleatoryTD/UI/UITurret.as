package com.hechoal.AleatoryTD.UI {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hechoal.AleatoryTD.Engine;
	
	
	public class UITurret extends Sprite {
		
		protected var ui:UIBox;
		protected var engine:Engine;
		
		static const _red:uint = 1;
		static const _green:uint = 2;
		static const _blue:uint = 3;
		static const _yellow:uint = 4;
		static const _magenta:uint = 5;
		static const _cyan:uint = 6;
		static const _white:uint = 7;
		
		public var price:uint;
		protected var dmg:uint;
		protected var rng:uint;
		protected var type:uint;
		protected var overFun:Function;
		
		public function UITurret(e:Engine,u:UIBox, xmlList:XMLList){
			ui = u;
			engine = e;
			
			var xml:XML =  new XML( xmlList );
			price = xml.price;
			dmg = xml.damage;
			rng = xml.range;
			
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_OUT, ui.outTurret,false,0,true);
		}

		public function clickUITurret():void{
			if(!buttonMode) return;
			engine.clickTower(type);
		}
		
		public function deactivate(){
			buttonMode = false;
			alpha = 0.5;
		}
		
		public function activate(){
			buttonMode = true;
			alpha = 1;
		}
		
		protected function statsToString():String{
			return "Price: "+price+"$\nDamage: "+ dmg+"    Range:" +rng
		}
		
	}
}