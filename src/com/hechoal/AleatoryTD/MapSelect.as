package com.hechoal.AleatoryTD {
	import flash.display.*;
	import com.hechoal.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import mochi.as3.*;
	import flash.text.*;
	import flash.ui.*;

	public class MapSelect extends MovieClip{
		
		private var backBut:BackButton = new BackButton();		
		private var loadBut:LoadMapBtn;
		private var moreBut:MoreMaps = new MoreMaps();
		private var stg:Stage;
		private var menuScreen:MenuScreen;
		private var engine:Engine;
		
		private var loadMap:LoadMap;
		var m1:Easy1 = new Easy1();
		var m2:Easy2 = new Easy2();
		var m3:Normal3 = new Normal3();
		var m4:Normal4 = new Normal4();
		var m5:Hard5 = new Hard5();
		var m6:Hard6 = new Hard6();
		
		private var _api:uint = 0;
		/*
		*	1 kong
		*	2 gamejolt
		*	3 flashjolt
		*
		*/
		const 	backx:uint = 229,
				backy:uint = 150,
				loadx:uint = 195,
				loady:uint = 220,
				morex:uint = 182,
				morey:uint = 220;

		public function MapSelect(_ms:MenuScreen){
			menuScreen = _ms;
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();			
			var copyrightNotice:ContextMenuItem = new ContextMenuItem("All rights reserved", false);
			var mySiteLink:ContextMenuItem = new ContextMenuItem("Loquat Games (link)",true);			
			mySiteLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, roars342);
			myMenu.customItems.push(mySiteLink, copyrightNotice);			
			contextMenu = myMenu;
			
		}
		public function setStg(_s:Stage) {
			stg = _s;
			addEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
		}
		private function doAddLinkEvent(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
			//Jalp.addButtonFb(new fbButton(29,179), Jalp.fbClick,this, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			//Jalp.addButtonTw(new twButton(29,241), Jalp.twClick, this, "http://x.mochiads.com/link/a2e89c2395d61e69");
			//Jalp.addButtonLg(new lgButton(439,179), Jalp.lgClick, this, "http://x.mochiads.com/link/f31215bfa734d272");
			Jalp.addMenuMapButtons(this);
			addStartButton(backx,backy, startClick);
			GamesChart.setup(stage,"15461ccdff66789695e86b4c0328f6b4");
			GamesChart.showTab(55,225);
			var url:String = stg.loaderInfo.url;

			if ( url.indexOf("tistory.com") != -1){
				return;
			}
			else if( url.indexOf("kongregate.com") != -1){
				addMoreButton(178,210, moreClick);
			}
			else{
				if ( url.indexOf("gamejolt.com") != -1)
				{
					
				}
				else{
					var mhs:MochiHS = new MochiHS();
					mhs.x = 372;
					mhs.y = 170;
					mhs.addEventListener(MouseEvent.CLICK, smlb);
					addChild(mhs);
				}
				
				loadMap = new LoadMap(this,stg);
				loadBut = new LoadMapBtn();
				loadBut.x = loadx;
				loadBut.y = loady;
				loadBut.addEventListener(MouseEvent.CLICK, loadCodeClk, false, 0 ,true);
				addChild(loadBut);
			}
			addMapButton(m1, 36, 313, easy1);
			addMapButton(m2, 36, 420, easy2);
			addMapButton(m3, 206, 313, normal3);
			addMapButton(m4, 206, 420, normal4);	
			addMapButton(m5, 376, 313, hard5);
			addMapButton(m6, 376, 420, hard6);
			
		}
		private function smlb(e:MouseEvent){
			MochiScores.showLeaderboard({boardID: "d1ece1bfec139efe",res:"550x550", width:550, height:550,onDisplay:stub,onClose:stub});
		}
		public function stub(){
		trace(".");
		}
		private function moreClick(myEvent:MouseEvent){	
			menuScreen.kongregate.sharedContent.browse("Maps", menuScreen.kongregate.sharedContent.BY_RATING);
		}
		public function setKong(){
			_api = 1;
		}
		public function setGJ():void{
			_api = 2;
		}
		private function addMapButton(_sb:SimpleButton, xx:uint, yy:uint, clk:Function){
			_sb.x = xx;
			_sb.y = yy;
			_sb.addEventListener(MouseEvent.CLICK, clk);
			addChild(_sb);
		}
		
		private function addStartButton(xx:uint, yy:uint, clk:Function){
			backBut.x = xx;
			backBut.y = yy;
			backBut.addEventListener(MouseEvent.CLICK, clk);
			addChild(backBut);
		}
		private function addMoreButton(xx:uint, yy:uint, clk:Function){
			moreBut.x = xx;
			moreBut.y = yy;
			moreBut.addEventListener(MouseEvent.CLICK, clk);
			addChild(moreBut);
		}
		private function addMoreButton2(xx:uint, yy:uint){
			moreBut.x = xx;
			moreBut.y = yy;
			moreBut.alpha = 0.5;
			addChild(moreBut);
		}
		private function startClick(myEvent:MouseEvent){	
			stg.addChild(menuScreen);
			stg.removeChild(this);	
		}

		private function easy1(e:MouseEvent){
			removeChild(m1);
			m1 = new Easy1();
			addMapButton(m1, 36, 313, easy1);
			
			mochi.as3.MochiEvents.startPlay("Easy1");
			engine = new Engine(this, Field.getmap(1), 1,menuScreen.kongregate);		
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			/*switch(_api){
				//case 1:	engine.setKong(); break;
				case 2: engine.setGJ(menuScreen.jolt);break;
				default:
			}*/
			stg.addChild(engine);
			trace("!");
			stg.removeChild(this);	
			trace("!");
		}		
		private function easy2(e:MouseEvent){	
			removeChild(m2);
			m2 = new Easy2();
			addMapButton(m2, 36, 420, easy2);
			
			mochi.as3.MochiEvents.startPlay("Easy2");
			engine = new Engine(this, Field.getmap(2), 2,menuScreen.kongregate);	
			if(_api == 2) {
				engine.setGJ(menuScreen.jolt);
				
			}
			stg.addChild(engine);
				stg.removeChild(this);	
		}		
		private function normal3(e:MouseEvent){	
			removeChild(m3);
			m3 = new Normal3();
			addMapButton(m3, 206, 313, normal3);
			mochi.as3.MochiEvents.startPlay("Normal1");
			engine = new Engine(this, Field.getmap(3), 3,menuScreen.kongregate);
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			stg.addChild(engine);
			stg.removeChild(this);	
		}		
		
		function roars342 (e:MouseEvent) {
			var request:URLRequest = new URLRequest("http://www.loquatgames.eu");
			navigateToURL(request);
		}
		private function normal4(e:MouseEvent){	
			removeChild(m4);
			m4 = new Normal4();
			addMapButton(m4, 206, 420, normal4);
			mochi.as3.MochiEvents.startPlay("Normal2");
			engine = new Engine(this, Field.getmap(4), 4,menuScreen.kongregate);
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			stg.addChild(engine);
		}
		private function hard5(e:MouseEvent){	
			removeChild(m5);
			m5 = new Hard5();
			addMapButton(m5, 376, 313, hard5);
			mochi.as3.MochiEvents.startPlay("Hard1");
			engine = new Engine(this, Field.getmap(5), 5,menuScreen.kongregate);
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			stg.addChild(engine);
			stg.removeChild(this);	
		}
		private function hard6(e:MouseEvent){			
			removeChild(m6);
			m6 = new Hard6();
			addMapButton(m6, 376, 420, hard6);
			mochi.as3.MochiEvents.startPlay("Hard2");
			engine = new Engine(this, Field.getmap(6), 6,menuScreen.kongregate);
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			stg.addChild(engine);
			stg.removeChild(this);	
		}
		
		public function custom(_la:Array, _dbl:Boolean){	
			if(engine != null && stg.contains(engine))
				engine.silentDestroy();
			mochi.as3.MochiEvents.startPlay("Custom");
			engine = new Engine(this, _la, 0,menuScreen.kongregate,_dbl);
			if(_api == 2) engine.setGJ(menuScreen.jolt);
			stg.addChild(engine);			
			stg.removeChild(this);	
		}
		/*
		public function onMapLoad(params:Object) {
			var id:Number        = params.id;
			var name:String      = params.name;
			var permalink:String = params.permalink;
			var content:String    = params.content;
			var label:String     = params.label;
			   
			trace("Maps " + id + " [" + label + "] loaded: " + content);
			var la:Array = new Array();
			for(var k:uint = 0; k<content.length-1; k++){
				if(content.charAt(k) == "0") la.push(0);
				else if(content.charAt(k) == "1") la.push(1);
				else if(content.charAt(k) == "2") la.push(0x10);
				else if(content.charAt(k) == "3") la.push(0x11);
				else if(content.charAt(k) == "4") la.push(0x100);
				else if(content.charAt(k) == "5") la.push(0x101);
				else if(content.charAt(k) == "6") la.push(0x110);
				else if(content.charAt(k) == "7") la.push(0x111);	
			}			
			la.push(content.slice(352,content.length));			
			custom(la);
		}
		*/
		public function relaunch(){
			trace("relaunch");
			stg.addChild(this);
			engine = null;
			GamesChart.showTab(55,225);
			//addChild(soundMuter);
		}
		
		public function loadCodeClk(e:MouseEvent){
			stg.removeChild(this);
			stg.addChild(loadMap);
			
		}
		private var ttb:TextField = new TextField();
		private var ttf:TextFormat = new TextFormat();	
		public function printMap(ss:String){
			ttb.x = 10;
			ttb.y = 10;
			ttb.width = 530;
			ttb.multiline = true;
			ttb.height = 200;
			ttb.text = ss;			
			ttf.font = "Arial";
			ttf.size = 10;
			ttf.color = 0xEEEEEE;	
			ttb.setTextFormat(ttf);
			addChild(ttb);
		}
	}	
	
}
