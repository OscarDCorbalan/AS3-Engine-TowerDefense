package com.hechoal.AleatoryTD {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ContextMenuEvent;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import com.hechoal.Jalp;
	import com.hechoal.twButton;
	import com.hechoal.fbButton;
	import com.hechoal.lgButton;
	import fl.controls.TextArea;
	import flash.utils.ByteArray;

	public class LoadMap extends MovieClip{

		var ti:TextArea = new TextArea();
		var stg:Stage;
		var map:MapSelect;
		var backBut:BackButton = new BackButton();
		var lmb:LoadCode = new LoadCode();
		
		public function LoadMap(_ms:MapSelect, _s:Stage) {
			map = _ms;
			stg = _s;
			addChild(ti);
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();			
			var copyrightNotice:ContextMenuItem = new ContextMenuItem("All rights reserved", false);
			var mySiteLink:ContextMenuItem = new ContextMenuItem("Loquat Games (link)",true);			
			mySiteLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, roars342);
			myMenu.customItems.push(mySiteLink, copyrightNotice);			
			contextMenu = myMenu;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			
		}
		function roars342 (e:MouseEvent) {
			var request:URLRequest = new URLRequest("http://www.loquatgames.eu");
			navigateToURL(request);
		}
		
		private function added(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, added);
			Jalp.addMenuLoadButtons(this);
			
			backBut.x = 228;
			backBut.y = 210;
			backBut.addEventListener(MouseEvent.CLICK, backClick);
			addChild(backBut);
			
			ti.x = 150;
			ti.y = 375;
			ti.width = 250;
			ti.height = 80;
			
			
			ti.text = "Put code here.";
			
			lmb.x = 334;
			lmb.y = 465;
			lmb.addEventListener(MouseEvent.CLICK, loadCodeClk, false, 0 ,true);
			addChild(lmb)
		}
		private function backClick(myEvent:MouseEvent){	
			stg.addChild(map);
			stg.removeChild(this);	
		}
		
		private function loadCodeClk(e:MouseEvent){
			try{
				var raw:ByteArray = new ByteArray();
				raw = StringtoBA(ti.text);
				raw.uncompress();
				var orig:String = raw.readObject();
				
				var la:Array = new Array();
				var k:uint = 0;
				var dbl:Boolean = false;
				if(orig.charAt(0) == "8"){
					k = 1;
					dbl = true;
				}
				for(; k<orig.length-1; k++){
					if(orig.charAt(k) == "0") la.push(0);
					else if(orig.charAt(k) == "1") la.push(1);
					else if(orig.charAt(k) == "2") la.push(0x10);
					else if(orig.charAt(k) == "3") la.push(0x11);
					else if(orig.charAt(k) == "4") la.push(0x100);
					else if(orig.charAt(k) == "5") la.push(0x101);
					else if(orig.charAt(k) == "6") la.push(0x110);
					else if(orig.charAt(k) == "7") la.push(0x111);	
				}			
				la.push(orig.slice(352,orig.length));		
				
				map.custom(la,dbl);
			}
			catch(e:Error){
				ti.text = "There is some error with the code.";
			}
			ti.text = "Put code here.";
		}
		
		
		
		function StringtoBA(s:String):ByteArray{
			var a:ByteArray = new ByteArray();
			for(var i:int = 0; i<s.length; i+=2){
				var b:uint = (hint(s.charAt(i))) + (hint(s.charAt(i+1))<<4);
				a.writeByte(b);
			}
			a.position = 0;
			return a;
		}
		function hint(s:String):uint {
			switch(s){
				case "0": return 0;
				case "1": return 1;
				case "2": return 2;
				case "3": return 3;
				case "4": return 4;
				case "5": return 5;
				case "6": return 6;
				case "7": return 7;
				case "8": return 8;
				case "9": return 9;
				case "a": return 10;
				case "b": return 11;
				case "c": return 12;
				case "d": return 13;
				case "e": return 14;
				case "f": return 15;
			}
			trace("invalid character");
			return 16;
		}
	}
	
}
