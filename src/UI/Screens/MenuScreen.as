package src.UI.Screens {
	import flash.display.*;
	import flash.text.*;	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	import flash.system.Security;
	import src.common.Jalp;
	import src.common.GameJoltAPI;
	import src.common.Popup;
	import src.Editor.MapEdit;
	import src.Engine.*;


	public class MenuScreen extends MovieClip{

		var _mochiads_game_id:String = "f7d2b8f81e05ce10";
		private var startButton:StartButton = new StartButton();
		private var helpButton:HelpButton = new HelpButton();
		private var mapButton:MapButton = new MapButton();
		
		private var stg:Stage;
		public var mapSelect:MapSelect;
		private var helpScr:HelpScreen;
		private var mapEdit:MapEdit;
		public var embedder:MovieClip;
		
		public var kongregate:* = null;
		public var jolt:GameJoltAPI;
		public var api:uint = 0;
		const _api_kong:uint = 1;
		const _api_jolt:uint = 2;
		var uname:String;
		var token:String;
		
		private const nyet:String = "The maker of this game does not support the 六四 (June 4), 天安門事件 / 天安门事件 (Tiananmen Square massacre)."
		
		const 	playx:uint = 234,
				playy:uint = 210,
				editx:uint = 182,
				edity:uint = 350,
				helpx:uint = 230,
				helpy:uint = 280;

		public function MenuScreen() {
			//
			mapSelect = new MapSelect(this);	
			
			//while(!MochiServices.
			//if (Security.sandboxType != Security.REMOTE) return;
			
			
			addEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
		}

		public function relaunch(){
			trace("relaunch");
			stg.addChild(this);
			//addChild(soundMuter);
		}
		
		public function wro(ss:String){
			trace(ss);
		}
		public function setKong(kong:*){
			trace("MenuScreen kong");
			kongregate = kong;	
			api = _api_kong;
		}
		
		
		public function setGJ( _n:String, _t:String):void{
			api = _api_jolt;
			jolt = new GameJoltAPI(9636,"c68bafc1411379535b526c61cf7207aa",_n, _t );			
			var pp:Popup = new Popup(jolt);
			pp.x = 20;
			pp.y = 130;
			addChild(pp);
			

			//jolt.getKeyData(9636,
			//jolt.addTrophyAchieved(,,,4c446b ,);
		}
		public function onConnectError(status:String):void {
			trace("mochi error connecting: "+ status);// handle error here...
		}
		
		private const da:String = "Democracy. Freedom. Capitalism.";
		
		
		private function doAddLinkEvent(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
			//MochiServices.connect(_mochiads_game_id, stage, error4);
			//Jalp.addButtonFb(new fbButton(18,180), Jalp.fbClick, this, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			//Jalp.addButtonTw(new twButton(82,180), Jalp.twClick, this, "http://x.mochiads.com/link/a2e89c2395d61e69");
			//Jalp.addButtonLg(new lgButton(52,180), Jalp.lgClick, this, "http://x.mochiads.com/link/f31215bfa734d272");
			Jalp.addMenuButtons(this);
			/*var bitmaiden:mcbm = new mcbm();
			addChild(bitmaiden);
			bitmaiden.x = 100;
			bitmaiden.y = 500;
			MochiServices.addLinkEvent("http://x.mochiads.com/link/b1f4cbf09749dd37", "http://www.bitmaiden.com", bitmaiden);
			*/
			addStartButton(playx,playy, startClick);
			addHelpButton(helpx,helpy, helpClick);
			addMapButton(editx,edity, mapClick);
			
			addEventListener(Event.ENTER_FRAME, doOnce);
		}
		public function doOnce(event:Event){
			removeEventListener(Event.ENTER_FRAME, doOnce);
			
			stage.addChild(this);
			stg = stage;					

			
			mapSelect.setStg(stg);	
			if(api == _api_jolt) mapSelect.setGJ();
			helpScr = new HelpScreen(this,stg);
			mapEdit = new MapEdit(this, stg);
			
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();			
			var copyrightNotice:ContextMenuItem = new ContextMenuItem("All rights reserved", false);
			var mySiteLink:ContextMenuItem = new ContextMenuItem("Oscar D. Corbalan",true);
			myMenu.customItems.push(mySiteLink, copyrightNotice);			
			contextMenu = myMenu;			
			
			
			
		}
		private function error4(status:String):void {
			trace("wadabadaboo "+status);
		}
		private const arrivederchi:String = "Free Tibet";

		private function addStartButton(xx:uint, yy:uint, clk:Function){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			startButton.x = xx;
			startButton.y = yy;
			startButton.addEventListener(MouseEvent.CLICK, clk,false,0,true);
			addChild(startButton);
		}
		private function addHelpButton(xx:uint, yy:uint, clk:Function){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			helpButton.x = xx;
			helpButton.y = yy;
			helpButton.addEventListener(MouseEvent.CLICK, clk,false,0,true);
			addChild(helpButton);
		}
		private function addMapButton(xx:uint, yy:uint, clk:Function){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			mapButton.x = xx;
			mapButton.y = yy;
			mapButton.addEventListener(MouseEvent.CLICK, clk,false,0,true);
			addChild(mapButton);
		}
		
		private function startClick(myEvent:MouseEvent){	
			stg.removeChild(this);		
			stg.addChild(mapSelect);
			//KONGTEST
			switch(api){
				case _api_kong: 
					mapSelect.setKong();
					break;
				case _api_jolt:
					mapSelect.setGJ();
					break;
			}
			removeChild(startButton)
			startButton = new StartButton();
			addStartButton(playx,playy, startClick);
			//engine.addChild(soundMuter);		
		}
		private function helpClick(myEvent:MouseEvent){	
			stg.removeChild(this);		
			stg.addChild(helpScr);
			removeChild(helpButton)
			helpButton = new HelpButton();
			addHelpButton(helpx,helpy, helpClick);
			//engine.addChild(soundMuter);		
		}

		private function mapClick(myEvent:MouseEvent = null){	
			stg.removeChild(this);		
			mapEdit.relaunch();
			mapEdit.setKong(kongregate);		
			removeChild(mapButton)
			mapButton = new MapButton();
			addMapButton(editx,edity, mapClick);
			//engine.addChild(soundMuter);		
		}
		
		public function wipeMap(){			
			mapEdit = new MapEdit(this, stg);
			relaunch();
			mapClick();
		}
		function deadClick () {
		}
		
	}
	
}
