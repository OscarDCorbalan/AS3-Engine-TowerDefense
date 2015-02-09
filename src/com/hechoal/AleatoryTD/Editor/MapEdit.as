package com.hechoal.AleatoryTD.Editor {
	import flash.display.*;
	import fl.controls.NumericStepper;
	import flash.events.Event;
	import flash.events.ContextMenuEvent
	import flash.text.*;
	import mochi.as3.*;
	import flash.events.MouseEvent;
	import com.hechoal.AleatoryTD.*;
	import com.hechoal.*;
	import flash.utils.ByteArray;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import fl.controls.CheckBox;
	
	public class MapEdit extends MovieClip{
		static const S:uint = 2;//2
		static const F:uint = 3;//3
		static const U:uint = 4;//4
		static const R:uint = 5;//5
		static const D:uint = 6;//6
		static const L:uint = 7;//7
		
		private var stg:Stage;
		private var menuScreen:MenuScreen;
		private var startButton:Play = new Play();
		private var testbut:TestButton = new TestButton();
		private var goback:MainMenu = new MainMenu();
		private var wipemap:WipeMap = new WipeMap();
		private var upload:Upload = new Upload();
		private var engine:Engine;
		private var lvlArray:Array;
		private var blocks:Array  = new Array();
		private var nene:NumericStepper;
		private var sgol:CheckBox;
		private var statsTf:TextFormat = new TextFormat();
		private var tfg:TextField = new TextField();
		private var tfr:TextField = new TextField();
		private var tnw:TextField = new TextField();
		private var tester:Tester;
		private var correct:Boolean = false;
		private var kongregate:*;
		private var jolt:GameJoltAPI;
		public function MapEdit(_ms:MenuScreen, _s:Stage) {
			menuScreen = _ms;
			stg = _s;			
			kongregate = null;
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();			
			var copyrightNotice:ContextMenuItem = new ContextMenuItem("All rights reserved", false);
			var mySiteLink:ContextMenuItem = new ContextMenuItem("Loquat Games (link)",true);			
			mySiteLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, roars342);
			myMenu.customItems.push(mySiteLink, copyrightNotice);			
			contextMenu = myMenu;
			statsTf.font = "Arial";
			statsTf.size = 10;
			statsTf.color = 0xEEEEEE;
			
			addEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
		}
		function roars342 (e:MouseEvent) {
			var request:URLRequest = new URLRequest("http://www.loquatgames.eu");
			navigateToURL(request);
		}
		private function doAddLinkEvent(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
			initStatField(tfg, 365, 423);
			initStatField(tfr, 382, 423);
			initStatField(tnw, 356, 456);

			addButton(testbut, 89,510, testClick);
			addButton(startButton, 361,510, startClick);	
			addButton(upload, 463,510, startClick);	
			addButton(goback, 458,462, backClick);
			addButton(wipemap, 458,430, wipeClick);
			makeRoad();
			Jalp.addButtonFb(new fbButton(172,517), Jalp.fbClick, this, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			Jalp.addButtonTw(new twButton(206,517), Jalp.twClick, this, "http://x.mochiads.com/link/a2e89c2395d61e69");
			Jalp.addButtonLg(new lgButton(240,517), Jalp.lgClick, this, "http://x.mochiads.com/link/f31215bfa734d272");
			GamesChart.hideTab();
			nene = new NumericStepper();
			nene.minimum = 1;
			nene.maximum = 20;
			nene.value = 10;
			nene.stepSize = 1;			
			nene.width = 40;
			nene.height = 15;
			nene.move(386,441);
			addChild(nene);
			
			sgol = new CheckBox();
			sgol.label = "";
			sgol.move(231,472);
			addChild(sgol);
			
			startButton.alpha = 0.5;
			startButton.mouseEnabled = false;
			upload.alpha = 0.5;
			upload.mouseEnabled = false;
			
			f5();
			f5w();
			nene.addEventListener(Event.CHANGE, f5w,false,0,true);
		}
		
		public function setKong(kong:*){
			trace("MapEdit kong");
			kongregate = kong;
		}

		private function f5w(e:Event=null){
			var i:uint,
				ng:uint = 0;
			lvlArray = new Array();
			for(i =0; i<352; i++){
				lvlArray.push(blocks[i].getType());
				if(blocks[i].getType() == S) ng++;
			}
			
			tnw.text = (nene.value * ng).toString();
			tnw.setTextFormat(statsTf);
		}
		
		private function addButton(_b:SimpleButton, xx:uint, yy:uint, clk:Function){
			_b.x = xx;
			_b.y = yy;
			_b.addEventListener(MouseEvent.CLICK, clk,false,0,true);
			addChild(_b);
		}
		private function remButton(_b:SimpleButton, clk:Function){
			_b.removeEventListener(MouseEvent.CLICK, clk);
			removeChild(_b);
		}
		
		public function returnTest(boo:Boolean){
			stg.addChild(this);
			tester = null;
			correct = boo;

			if(correct){
				startButton.addEventListener(MouseEvent.CLICK,startClick,false,0,true);
				startButton.alpha = 1;
				startButton.mouseEnabled = true;
				upload.addEventListener(MouseEvent.CLICK,uploadClick);
				upload.alpha = 1;
				upload.mouseEnabled = true;
			}
			else{
				startButton.removeEventListener(MouseEvent.CLICK,startClick);
				startButton.alpha = 0.5;
				startButton.mouseEnabled = false;
				upload.removeEventListener(MouseEvent.CLICK,uploadClick);
				upload.alpha = 0.5;
				upload.mouseEnabled = false;
			}
		}
		
		private function testClick(myEvent:MouseEvent){	
			mochi.as3.MochiEvents.startPlay("EditorMap");
			
			lvlArray = new Array();
			for(var i:uint =0; i<352; i++){
				switch(blocks[i].getType()){
					case 0: lvlArray.push(0); break;
					case 1: lvlArray.push(1); break;
					case 2: lvlArray.push(0x10); break;
					case 3: lvlArray.push(0x11); break;
					case 4: lvlArray.push(0x100); break;
					case 5: lvlArray.push(0x101); break;
					case 6: lvlArray.push(0x110); break;
					case 7: lvlArray.push(0x111); break;
					default: trace("Editor parsing error");
				}
				//lvlArray.push(blocks[i].getType());
			}
			lvlArray.push(nene.value);
			
			tester = new Tester(this, lvlArray);
			
			stg.removeChild(this);			
			stg.addChild(tester);
			bmp = new Bitmap( Jalp.getBitmapData( tester ) );
		}
		
		private function startClick(myEvent:MouseEvent){	
			mochi.as3.MochiEvents.startPlay("EditorMap");
			
			lvlArray = new Array();
			for(var i:uint =0; i<352; i++){
				switch(blocks[i].getType()){
					case 0: lvlArray.push(0); break;
					case 1: lvlArray.push(1); break;
					case 2: lvlArray.push(0x10); break;
					case 3: lvlArray.push(0x11); break;
					case 4: lvlArray.push(0x100); break;
					case 5: lvlArray.push(0x101); break;
					case 6: lvlArray.push(0x110); break;
					case 7: lvlArray.push(0x111); break;
					default: trace("Editor parsing error");
				}
				//lvlArray.push(blocks[i].getType());
			}
			lvlArray.push(nene.value);
			
			engine = new Engine(this, lvlArray, 0,kongregate, sgol.selected);	
			if(menuScreen.api == 2) engine.setGJ(menuScreen.jolt);
			stg.removeChild(this);			
			stg.addChild(engine);
		}
		
		var bmp:Bitmap;
		var levelstring:String;
		private function uploadClick(myEvent:MouseEvent){	
			var chain:String = "";
			if( sgol.selected) chain = chain.concat("8");
			for(var i:uint =0; i<352; i++){
				switch(blocks[i].getType()){
					case 0: chain = chain.concat("0"); break;
					case 1: chain = chain.concat("1"); break;
					case 2: chain = chain.concat("2"); break;
					case 3: chain = chain.concat("3"); break;
					case 4: chain = chain.concat("4"); break;
					case 5: chain = chain.concat("5"); break;
					case 6: chain = chain.concat("6"); break;
					case 7: chain = chain.concat("7"); break;					
					default: trace("Editor parsing error");
				}
			}
			chain = chain.concat(nene.value.toString());			
			
			var sp:Sprite = new Sprite();
			sp.addChild(bmp);
			
			
			var raw:ByteArray = new ByteArray();
			raw.writeObject(chain);
			raw.compress();
			levelstring = BAtoString(raw);
			if(kongregate != null) kongregate.sharedContent.save("Maps", chain, onSaved, sp);	
			//else if(jolt != null) jolt.setKeyData(jolt.gi,jolt.pk,
			else onSaved(null);
		}
		
		private function BAtoString(a:ByteArray):String{
			var s:String = "";
			a.position = 0;
			while(a.bytesAvailable){
				var b:uint = a.readByte();
				s += ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'][b%16];
				b=b>>4;
				s += ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'][b%16];
			}
			a.position = 0;
			return s;
		}
		
		

		function onSaved(params:Object) {
			if (params != null && params.success) {
				// The shared content was saved successfully.
				trace("Content saved, id:" + params.id + ", name:" + params.name);
				kongregate.stats.submit("UploadShared", 1); 
				var mess:UploadOK = new UploadOK(200);
				mess.x = 65;
				mess.y = 65;
				addChild(mess);
			} else {
				var mess2:UploadNOK = new UploadNOK(350,levelstring);
				mess2.x = 100;
				mess2.y = 65;
				addChild(mess2);
				
				
			}
		}
		private function backClick(myEvent:MouseEvent){				
			stg.removeChild(this);			
			stg.addChild(menuScreen);	
			removeChild(goback)
			goback = new MainMenu();
			addButton(goback, 458,462, backClick);
		}
		
		private function wipeClick(myEvent:MouseEvent){				
			stg.removeChild(this);
			menuScreen.wipeMap();
		}
		
		public function relaunch(){
			trace("relaunch");
			stg.addChild(this);
			
			//addChild(soundMuter);
		}

		
		public function f5(e:Event = null){
			var i:uint,
				ng:uint = 0,
				nr:uint = 0;
			correct = false;
			startButton.removeEventListener(MouseEvent.CLICK,startClick);
			startButton.alpha = 0.5;
			startButton.mouseEnabled = false;
			upload.removeEventListener(MouseEvent.CLICK,startClick);
			upload.alpha = 0.5;
			upload.mouseEnabled = false;
			lvlArray = new Array();
			for(i =0; i<352; i++){
				lvlArray.push(blocks[i].getType());
				if(blocks[i].getType() == S) ng++;
				else if(blocks[i].getType() == F) nr++;
			}
			var boo:Boolean = true;
			
			//trace(lvlArray);
			if(ng > 0) tfg.text = ng.toString();
			else{ tfg.text = "0"; boo = false;}
			tfg.setTextFormat(statsTf);

			if(nr > 0) tfr.text = nr.toString();
			else {tfr.text = "0"; boo = false;}
			tfr.setTextFormat(statsTf);
			
			tnw.text = (nene.value * ng).toString();
			tnw.setTextFormat(statsTf);
			
			if(boo){
				testbut.addEventListener(MouseEvent.CLICK,testClick);
				testbut.alpha = 1;
				testbut.mouseEnabled = true;
			}
			else{
				testbut.removeEventListener(MouseEvent.CLICK,testClick);
				testbut.alpha = 0.5;
				testbut.mouseEnabled = false;
			}
		}
		
		private function makeRoad(){
			var row:int = 0;
			var block;
			var c:int,
				i:uint;
			
			for(i=0; i<352; i++){
				if(i == 0 || i==21 || i==330 || i ==351){
					block = new AngleTD(this);
				}
				else if(row == 0 || row == 15 || i%22 == 0 || i%22 == 21){
					if(row == 0) {
						block = new BorderTD(this,0);					
					}else if(row == 15){
						block = new BorderTD(this,1);
					}else if(i%22 == 0){
						block = new BorderTD(this,2);
					}else if(i%22 == 21){
						block = new BorderTD(this,3);
					}					
				}
				else{
					block = new SquareTD(this);
				}
				
				block.x = (i-row*22)*25;
				block.y = row*25;
				addChild(block);
				blocks.push(block);
				block = null;
				
				for(c = 1;c<=16;c++){
					if(i == c*22-1){
						row++;
					}
				}
				
			}
			block = null;
		}
		
		private function initStatField(t:TextField, xx:uint, yy:uint){
			t.x = xx;
			t.y = yy;
			t.selectable = false;
			t.autoSize = TextFieldAutoSize.LEFT;
			addChild(t);				
		}
		
	}
	
}
