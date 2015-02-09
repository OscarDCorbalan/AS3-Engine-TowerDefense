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

	public class HelpScreen extends MovieClip{

		var stg:Stage;
		var menu:MenuScreen;
		var backBut:BackButton = new BackButton();
		
		public function HelpScreen(_ms:MenuScreen, _s:Stage) {
			menu = _ms;
			stg = _s;
			
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
			Jalp.addMenuMapButtons(this);
			
			backBut.x = 228;
			backBut.y = 170;
			backBut.addEventListener(MouseEvent.CLICK, backClick);
			addChild(backBut);
			
		}
		private function backClick(myEvent:MouseEvent){	
			stg.addChild(menu);
			stg.removeChild(this);	
			removeChild(backBut);
			backBut.removeEventListener(MouseEvent.CLICK, backClick);
			backBut = new BackButton();
			backBut.x = 228;
			backBut.y = 170;
			backBut.addEventListener(MouseEvent.CLICK, backClick);
			addChild(backBut);
		}
		
	}
	
}
