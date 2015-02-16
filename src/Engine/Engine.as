package src.Engine {

	import flash.display.*;	
	import flash.events.*;
	import flash.external.ExternalInterface;	
	import flash.geom.Matrix;
	import flash.media.SoundChannel;
	import flash.media.Sound;	
	import flash.net.*;
	import flash.system.Security;	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.*;	
	import flash.utils.ByteArray;
	import src.common.GameJoltAPI;
	import src.common.Jalp;
	import src.common.SWFProfiler;	
	import src.Engine.Turrets.*;
	import src.Engine.Enemies.*;
	import src.ObjectPool.ObjectPool;	
	import src.UI.*;
	import src.UI.Screens.Lost;
	import src.UI.Screens.Won;
	
	public class Engine extends MovieClip{
		
		[Embed(source="/assets/data.xml", mimeType="application/octet-stream")] 
		const EmbeddedXML:Class;
		var xml:XML = new XML();
		
		public var poolP:ObjectPool;
		private var poolY:ObjectPool;
		private var poolC:ObjectPool;
		private var poolM:ObjectPool;
		
		//public var eff:Bitmap;
		//public var effData:BitmapData;
		static const S:uint = 0x010;
		static const F:uint = 0x011;
		static const U:uint = 0x100;
		static const R:uint = 0x101;
		static const D:uint = 0x110;
		static const L:uint = 0x111;
		
		static const _boss:uint = 0;
		static const _red:uint = 1;
		static const _green:uint = 2;
		static const _blue:uint = 3;
		static const _yellow:uint = 4;
		static const _magenta:uint = 5;
		static const _cyan:uint = 6;
		static const _gray:uint = 7;
		
		public var colorEmpty:uint = 0x133937;
		
		public var gameOver:Boolean = false;
		public var startDir:Array = new Array();//uint;//the direction the enemies go when they enter
		public var finDir:Array = new Array();//:uint;//the direction the enemies go when they exit		
		public var startCoord:Array = new Array();//:int;//the coordinates of the beginning of the road
		
		public var tCost:Vector.<uint>;
		//public var startCoord2:Vector.<uint> = [0
		private var lvlArray:Array;
		public var kills = 0;
		public var bosskills = 0;
		
		var level:uint;
		var currentEnemy:int = 0;//the current enemy that we"re creating from the array
		var enemyTime:int = 0;//how many frames have elapsed since the last enemy was created
		var enemyLimit:int = 12;//how many frames are allowed before another enemy is created
		var enemiesLeft:int;//how many enemies are left on the field
		
		//the names of these variables explain what they do
		var currentLvl:int = 1;
		
		//create an object that will hold all parts of the road			
		var roadHolder:Sprite = new Sprite();
		public var enemyHolder:Sprite = new Sprite();
		public var turretHolder:Sprite = new Sprite();
		public var effectsHolder:Sprite = new Sprite();
		
		public var ui:UIBox;
		public var uistats:UIStats;
		private var autowaves:Boolean;
		private var blindmode:Boolean;
		private var infinite:Boolean = false;
		private var infinitehpbase:uint = 57500;
		public var floatingTower:Sprite;
		public var floatingTowerType:uint;
		
		var waveLength:uint;// = new Vector();
		var waveCreated:Array;// = new Vector();
		public var hpEnemy:Array;
		public var mnEnemy:Array;
		var att:Vector.<uint>;
		
		private var menuScreen:MovieClip;
		private var i:uint;
		var soundControl:SoundChannel = new SoundChannel();
		var mapid:uint;
		var kongregate:* = null;
		var jolt:GameJoltAPI = null;
		
		public function Engine(_ms:MovieClip, _la:Array, _map:uint, _kong:*, _dbl:Boolean = false) {
			menuScreen = _ms;
			lvlArray = _la;
			mapid = _map;
			kongregate = _kong;
			var _sgol:uint = _dbl? 250 : 0;
			
			var _btm:Bitmap = new Bitmap(new mifas(0, 0));
			var _spr:Sprite = new Sprite();
			_spr.addChild(_btm);
			addChild(_spr);
			_spr.x=0;
			_spr.y=0;
			
			
			
			var contentfile:ByteArray = new EmbeddedXML();
			var contentstr:String = contentfile.readUTFBytes( contentfile.length );
			xml = new XML( contentstr );	
			
			poolP = new ObjectPool(Class(Particle),15);
			poolY = new ObjectPool(Class(Triangulation), 1);
			poolC = new ObjectPool(Class(GravityBullet), 5);
			poolM = new ObjectPool(Class(Ray), 5);
			tCost = new Vector.<uint>(7);
			colorEmpty = 0x0B5682;			
			
			addChild(roadHolder);
			makeRoad();	
			addChild(enemyHolder);
			enemyHolder.mouseEnabled = false;
			enemyHolder.mouseChildren = false;
			addChild(turretHolder);
			addChild(effectsHolder);
			effectsHolder.mouseEnabled = false;
			effectsHolder.mouseChildren = false;
			/*if (Security.sandboxType != Security.REMOTE)
			{
				removeChild(enemyHolder);
			}*/
			
			var _btm2:Bitmap = new Bitmap(new uibottom(0, 0));
			var _spr2:Sprite = new Sprite();
			_spr2.addChild(_btm2);
			addChild(_spr2);			
			_spr2.y=401;
			
			ui = new UIBox(this, 40 ,xml.Turrets);
			ui.y=400;
			addChild(ui);
			uistats = ui.getUIStats();
			var basemoney:int = _dbl? 500: xml.money;
			if(_map == 1 || _map == 2) basemoney -= 50;
			else if(_map == 5 || _map == 6) basemoney += 50;
			uistats.setMoney(basemoney);
			uistats.setLives(xml.lives);
			
			hpEnemy = new Array(0,150, 200,250,320,410,510,660,825,1065,1350,
			1500,1700,2250,2900,4125,4750,6000,7500,9500,12000,
			11800,14000,16250,18500,20500,22750,25000,27000,28800,30000,
			32000,34000,36000,39000,42000,45000,48000,50500,53000,50000);
			//32000,33500,35000,36500,38000,40500,42000,43500,45000,40000
					
			
			
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);	
			//trace(xml);
		}		
		
		public function setGJ(_gj:GameJoltAPI){
			jolt = _gj;

		}
		private function playTrack(event:MouseEvent=null){
			var _s:Track = new Track();
			soundControl = _s.play();
			soundControl.addEventListener(Event.SOUND_COMPLETE,handleSoundComplete);
			
		}
		function handleSoundComplete(event:Event){
		 playTrack();
		}
		
		private function init(e:Event):void {		
			removeEventListener(Event.ADDED_TO_STAGE, init);	
			var mftjy:String = loaderInfo.url;
			var len:uint = xml.Waves.Wave.length();
			trace("len "+len);
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();			
			var copyrightNotice:ContextMenuItem = new ContextMenuItem("All rights reserved", false);
			var mySiteLink:ContextMenuItem = new ContextMenuItem("Loquat Games (link)",true);			
			mySiteLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, roars342);
			myMenu.customItems.push(mySiteLink, copyrightNotice);			
			contextMenu = myMenu;
			
			waveCreated = new Array();
			var gf4g2:RegExp = new RegExp("^http(|s)://");
			//hpEnemy = new Vector.<uint>(len+1);
			mnEnemy = new Array();
			tCost[_red] = xml.Turrets.Red.price;
			tCost[_blue] = xml.Turrets.Blue.price;
			tCost[_green] = xml.Turrets.Green.price;
			tCost[_cyan] = xml.Turrets.Cyan.price;
			tCost[_yellow] = xml.Turrets.Yellow.price;
			tCost[_magenta] = xml.Turrets.Magenta.price;
			
			
			var hpbase:uint = xml.Waves.hp,
				hpinc:Number = xml.Waves.hpinc,
				mnbase:uint = xml.Waves.money,
				mninc:uint = xml.Waves.moneyinc;

			att = Vector.<uint>([7,6,5,4,7,2,1,3,7,0]);
			waveLength = lvlArray[lvlArray.length-1];
			
			i = 0;
			waveCreated.push(0);
			mnEnemy.push(0)
			for(i = 0; i < 40; i++){
				waveCreated.push(0);
				mnEnemy.push(mnbase+i);
			}

			level = 0;
			trace("hpenemy: " + hpEnemy);
			trace("mnenemy: " + mnEnemy);
			ui.setNextWave(att[0], 1);		
			
			
			tabChildren = false; 
 			tabEnabled = false; 
			
					
			playTrack();
			trace("A");
			
			
			
			addEventListener(Event.ENTER_FRAME, eFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			addEventListener(MouseEvent.CLICK, onClickHandler);
			
			//GamesChart.hideTab();
		}
		
		
		
		private function onClickHandler(e:MouseEvent){
			trace(e.target);
			if(e.target.parent is Turret && (floatingTower == null 
				|| floatingTower != null && !contains(floatingTower)))
			{				
				e.target.parent.clickTurret();
			}
			else if(e.target is UITurret){
				ui.clearUI();
				e.target.clickUITurret();				
			}
			else if(e.target is EmptyBlock || e.target is DirectBlock || e.target is Sprite){
				if(floatingTower != null && contains(floatingTower)){
					clearFloatingTower();
				}				
				ui.clearUI();
			}
			
			addChild(ui);
		}
		
		var _hp:uint = 57500
		public function sendNextWave(){
			level++;
			uistats.setLevel(level);
			trace("level "+ level);
			
			if(level>=40){
				mnEnemy.push(mnEnemy.length + 4);
				waveCreated.push(0);
				_hp += (level-36)*400;
				hpEnemy.push(_hp);
			}
			
			ui.setCurrentWave(att[(level-1)%10], level);			
			
			if(level+1<41){
				ui.setNextWave(att[(level)%10], level+1);
			}
			else if(infinite){				
				ui.setNextWave(att[(level)%10], level+1);
			}

			
			if(kongregate == null) return; 
			kongreport(false);
			
		}
		
		var _checklast:Boolean = false;
		public function lastlevel(){
			_checklast = true;
		}

		function eFrame(e:Event):void{
			if(gameOver){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
				return;
			}
			else if(_checklast && !infinite && enemyHolder.numChildren == 0){
				destroyThis(true);
				removeEventListener(Event.ENTER_FRAME, eFrame);
				return;				
			}
			if(floatingTower != null && contains(floatingTower)){
				floatingTower.x = 1+mouseX - (mouseX%25);
				floatingTower.y = 1+mouseY - (mouseY%25);
			}
			
			makeEnemies();
		}
		
		
		 
		var type:uint;
		var _newEnemy:Enemy;
		function makeEnemies():void{
			if(level == 0) return;
			if(waveCreated[level] >= waveLength){
				ui.activateNextWave();
				if(autowaves && (level+1<41 || infinite) )
					ui.sendNextWave();
					
				else{
					autowaves = false
				}
				return;
			}
			if(enemyTime < enemyLimit){
				enemyTime ++;
				return;
			}
			//trace("type = " +att[level%10]);
			type = att[(level-1)%10];
			for(i=0; i<startCoord.length; i++){
				switch(type){
					case _boss:
						_newEnemy = new EnemyBoss(this, type, Math.random() * startCoord.length, level);
						i = int.MAX_VALUE;
						waveCreated[level] = int.MAX_VALUE;
						break;
					case _red:
						_newEnemy = new EnemyRed(this, type, i,level);
						break;
					case _green:
						_newEnemy = new EnemyGreen(this, type, i,level);
						break;
					case _blue:
						_newEnemy = new EnemyBlue(this, type, i,level);
						break;
					case _yellow:
						_newEnemy = new EnemyYellow(this, type, i,level);
						break;
					case _magenta:
						_newEnemy = new EnemyMagenta(this, type, i,level);
						break;
					case _cyan:
						_newEnemy = new EnemyCyan(this, type, i,level);
						break;
					case _gray:
						_newEnemy = new EnemyGray(this, type, i,level);
						break;
					default:
						trace("unstarted ");
				}
				enemyHolder.addChild(_newEnemy);
				_newEnemy = null;
			}
			waveCreated[level]++;
			enemyTime = 0;
			if(level == 40) lastlevel();
		}

		function makeTurret(xValue:int, yValue:int):void{
			var turret:Turret;
			uistats.subMoney(tCost[floatingTowerType]);
			switch(floatingTowerType){
				case _red:
					turret = new TurretRed(ui,xml);
					break;
				case _green:
					turret = new TurretGreen(ui,xml);
					break;
				case _blue:
					turret = new TurretBlue(ui,xml);
					break;
				case _cyan:
					turret = new TurretCyan(ui,xml, poolC);
					break;
				case _yellow:
					turret = new TurretYellow(ui, xml, poolY);
					break;	
				case _magenta:
					turret = new TurretMagenta(ui,xml,poolM);
					break;
				default: return;
			}
			//changing the coordinates
			turret.x = xValue+12.5;
			turret.y = yValue+12.5;
			turretHolder.addChild(turret);
			turret = null;
			clearFloatingTower();
		}

		function makeRoad():void{
			var row:int = 0;
			var block;
			var c:int;
			var m:Matrix = new Matrix();
			for(i=0;i<lvlArray.length-1;i++){
				if(lvlArray[i] == 1){
					block = new Shape();
					block.graphics.beginFill(0);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);//add it to the roadHolder
				} else if(lvlArray[i] == S){
					block = new Shape();
					if(row == 0) {
						m.createGradientBox(25,25,Math.PI/2,0,0);					
					}else if(row == 15){
						m.createGradientBox(25,25,3*Math.PI/2,0,0);
					}else if(i%22 == 0){
						m.createGradientBox(25,25,0,0,0);
					}else if(i%22 == 21){
						m.createGradientBox(25,25,Math.PI,0,0);
					}
					block.graphics.beginGradientFill(GradientType.LINEAR, [0x00c000, 0x000000], [1,1], [0,180], m);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);//add it to the roadHolder
					if(block.x == 0){
						startDir.push(R);
						startCoord.push(block.y);
					} else if (block.y == 0){
						startDir.push(D);
						startCoord.push(block.x);
					} else if (block.x == 525){
						startDir.push(L);
						startCoord.push(block.y);
					} else if (block.y == 375){
						startDir.push(U);
						startCoord.push(block.x);
					} else {					
						trace("DirectBlock.beginClass(...) START else");
					}
				}
				else if(lvlArray[i] == F){
					block = new Shape();
					if(row == 0) {
						m.createGradientBox(25,25,Math.PI/2,0,0);					
					}else if(row == 15){
						m.createGradientBox(25,25,3*Math.PI/2,0,0);
					}else if(i%22 == 0){
						m.createGradientBox(25,25,0,0,0);
					}else if(i%22 == 21){
						m.createGradientBox(25,25,Math.PI,0,0);
					}
					block.graphics.beginGradientFill(GradientType.LINEAR, [0xc00000, 0x000000], [1,1], [0,180], m);
					//beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0)
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);//add it to the roadHolder
				}				
				else if(lvlArray[i] >= 0x100){
					block = new Shape();
					block.graphics.beginFill(0);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);
					block = new DirectBlock(this,lvlArray[i],(i-row*22)*25,row*25);
					addChild(block);
				}
				else if(lvlArray[i] != 0)
					trace("Error. lvlArray"+i+"="+lvlArray[i]);
					
				block = null;
				
				for(c = 1;c<=16;c++){
					if(i == c*22-1){
						row++;
					}
				}
				
			}
			row=0;
			for(i=0;i<lvlArray.length-1;i++){
				if(lvlArray[i] == 0){		
					block = new EmptyBlock(this);
					addChild(block);
					block.x= (i-row*22)*25;
					block.y = row*25;
				}
				for(c = 1;c<=16;c++){
					if(i == c*22-1){
						row++;
					}
				}
			}
			block = null;
		}
		
		function roars342 (e:MouseEvent) {
			var request:URLRequest = new URLRequest("http://www.loquatgames.eu");
			navigateToURL(request);
		}
		public function clickTower(type:uint){
			var image:Bitmap,
				range:uint;
			switch(type){
				case _red:
					image = new Bitmap(new red1(0, 0));
					range = xml.Turrets.Red.range;
					break;
				case _green:
					image = new Bitmap(new green1(0, 0));
					range = xml.Turrets.Green.range;
					break;
				case _blue:
					image = new Bitmap(new blue1(0, 0));
					range = xml.Turrets.Blue.range;
					break;
				case _cyan:
					image = new Bitmap(new cyan1(0, 0));
					range = xml.Turrets.Cyan.range;
					break;	
				case _yellow:
					image = new Bitmap(new yellow1(0, 0));
					range = xml.Turrets.Yellow.range;
					break;		
				case _magenta:
					image = new Bitmap(new magenta1(0, 0));
					range = xml.Turrets.Magenta.range;
					break;		
				default: return;
			}
			
			if (floatingTower != null && contains(floatingTower)){
				clearFloatingTower();			
			}			
			floatingTowerType = type ;
			initFloatingTower();
			floatingTower.graphics.lineStyle(1,0xEEEEEE);
			floatingTower.graphics.drawCircle(12.5,12.5,range);
			floatingTower.addChild(image);
			image = null;
			addChild(floatingTower);			
		}
		
		private function keyPressed(evnt:KeyboardEvent){
			trace("key pressed");
			if (evnt.keyCode == Keyboard.ESCAPE && floatingTower != null && contains(floatingTower)) {
				clearFloatingTower();
			}
			else if (evnt.keyCode == Keyboard.NUMBER_1) {
				ui.clickUITurret(1);
			}
			else if (evnt.keyCode == Keyboard.NUMBER_2) {
				ui.clickUITurret(2);
			}
			else if (evnt.keyCode == Keyboard.NUMBER_3) {
				ui.clickUITurret(3);
			}
			else if (evnt.keyCode == Keyboard.NUMBER_4) {
				ui.clickUITurret(4);
			}
			else if (evnt.keyCode == Keyboard.NUMBER_5) {
				ui.clickUITurret(5);
			}
			else if (evnt.keyCode == Keyboard.NUMBER_6) {
				ui.clickUITurret(6);
			}
			//else if(evnt.keyCode == 9){
				//gameOver = true;
			//}
		}
		
		private function clearFloatingTower(){
			floatingTower.graphics.clear();
			removeChild(floatingTower);
			floatingTowerType = 0;
			floatingTower.removeChildAt(0);
			floatingTower = null;
		}
		
		public function removeLife(){
			uistats.removeLife();
			if(uistats.getLives() <= 0) gameOver=true;
		}
		
		public function addMoney(n:uint){
			uistats.addMoney(n);
			kills++;
		}
		
		public function addScore(n:uint){
			uistats.addScore(n);
		}
		private function initFloatingTower(){
			floatingTower = new Sprite();
			floatingTower.buttonMode = false;
			floatingTower.mouseChildren = false;
			floatingTower.mouseEnabled = false;
		}
		
		private function kongreport(won:Boolean){
			if(kongregate == null) return;
			kongregate.stats.submit("Score", uistats.getScore());
			kongregate.stats.submit("KillsTotal", kills); 
			kongregate.stats.submit("Kills", kills);
			if(won) level++;
			switch(mapid){
				case 0:
					kongregate.stats.submit("Custom", level); 
					break;
				case 1:
					kongregate.stats.submit("Easy", level); 
					kongregate.stats.submit("Slot", level); 
					break;
				case 2:
					kongregate.stats.submit("Easy", level); 
					kongregate.stats.submit("Milky", level); 
					break;
				case 3:
					kongregate.stats.submit("Normal", level); 
					kongregate.stats.submit("Really", level); 
					break;
				case 4:
					kongregate.stats.submit("Normal", level); 
					kongregate.stats.submit("Deox", level); 
					break;
				case 5:
					kongregate.stats.submit("Hard", level); 
					kongregate.stats.submit("Veni", level); 
					break;
				case 6:
					kongregate.stats.submit("Hard", level); 
					kongregate.stats.submit("Waste", level); 
					break;
			}
		}

		private function joltreport(won:Boolean){
			if(jolt == null) {				
				return;
			}
			if(won) level++;
			switch(mapid){
				case 0:
					if(level>40) jolt.addTrophyAchieved(841);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9660);
					break;
				case 1:
					if(level>40) jolt.addTrophyAchieved(834);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9662);
					break;
				case 2:
					if(level>40) jolt.addTrophyAchieved(835);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9663);
					break;
				case 3:
					if(level>40) jolt.addTrophyAchieved(837);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9664);
					break;
				case 4:
					if(level>40) jolt.addTrophyAchieved(836);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9665);
					break;
				case 5:
					if(level>40) jolt.addTrophyAchieved(838);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9666);
					break;
				case 6:
					if(level>40) jolt.addTrophyAchieved(839);
					jolt.setHighscore(uistats.getScore().toString(), uistats.getScore(),9667);
					break;
			}
			jolt.getTrophyData("all", joltAllTrophies);
		}
		
		public function joltAllTrophies(_a:Array){
			var _count:uint = 0;
			for(var ii=0; ii < 8; ii++){
				if(_a["achieved"][ii] != "false")
					_count++;
			}
			if(_count == 7) 
				jolt.addTrophyAchieved(840);
		}
		
		public function stub(){
			trace(".");
		}
		private function destroyThis(won:Boolean = false){
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			removeEventListener(MouseEvent.CLICK, onClickHandler);
			stage.frameRate = 24;
			//GamesChart.showTab(260,400);
			var bmp:Bitmap = new Bitmap( Jalp.getBitmapData( this ) );
			var sp:Sprite = new Sprite();
			sp.addChild(bmp);
			addChild(sp);			
			sp.alpha = 0.5;
			
			kongreport(won);
			joltreport(won);
			
			var url:String = stage.loaderInfo.url;
			if ( url.indexOf("flashjolt.com") != -1){
				var conn:LocalConnection = new LocalConnection();
 				conn.send("flashJoltAPI", "sendScore", uistats.getScore());
			}
			
			if(won){				
				var woni:Won = new Won();
				woni.setKong(kongregate);
				woni.something(level,uistats.getLives(),uistats.getScore(),kills,bosskills);
				woni.backBut.addEventListener(MouseEvent.CLICK, backtomenu,false,0,true);
				addChild(woni);
			}
			else{
				var lost:Lost = new Lost();
				lost.setKong(kongregate);
				lost.something(level,uistats.getLives(),uistats.getScore(),kills,bosskills);
				lost.backBut.addEventListener(MouseEvent.CLICK, backtomenu,false,0,true);
				addChild(lost);
			}
				
			
			removeChild(ui);
			ui = null;
			uistats = null;
			if(floatingTower!= null && contains(floatingTower)){
				removeChild(floatingTower);
			}
			floatingTower = null
			startDir = []; startDir = null;
			finDir = []; finDir = null;
			startCoord = []; startCoord = null;
			lvlArray = []; lvlArray = null;
			tCost = null;	
			soundControl.stop();
			soundControl = null;
			removeChild(roadHolder);
			removeChild(enemyHolder);
			removeChild(effectsHolder);			
			roadHolder = null;
			enemyHolder = null;
			effectsHolder = null;
		}
		
		public function silentDestroy(){
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			removeEventListener(MouseEvent.CLICK, onClickHandler);
			stage.frameRate = 24;
			kongreport(false);			
			removeChild(ui);
			ui = null;
			uistats = null;
			if(floatingTower!= null && contains(floatingTower)){
				removeChild(floatingTower);
			}
			floatingTower = null
			startDir = []; startDir = null;
			finDir = []; finDir = null;
			startCoord = []; startCoord = null;
			lvlArray = []; lvlArray = null;
			tCost = null;	
			soundControl.stop();
			soundControl = null;
			removeChild(roadHolder);
			removeChild(enemyHolder);
			removeChild(effectsHolder);			
			roadHolder = null;
			enemyHolder = null;
			effectsHolder = null;				
			xml = null;
			att = null;						
			waveCreated = null;
			hpEnemy = null;
			mnEnemy = null;	
		}
		
		private function backtomenu(e:MouseEvent = null){
			//GamesChart.hideTab();
			xml = null;
			att = null;						
			waveCreated = null;
			hpEnemy = null;
			mnEnemy = null;			
			stage.addChild(menuScreen);
			stage.removeChild(this);
			//GamesChart.showTab(55,225);
		}
		public function setAutoWaves(_a:Boolean){
			autowaves = _a;
			trace(autowaves);
		}
		
		public function setBlindMode(_a:Boolean){
			blindmode = _a;
			trace(blindmode);
		}
		
		public function quitToMenu(e:MouseEvent){
			gameOver = true;
			removeEventListener(Event.ENTER_FRAME, eFrame);
			destroyThis(level>40);
		}
		public function infiniteOn(){
			trace(level);
			infinite = true;
			ui.setInfinite();
			if(level == 40){
				ui.setNextWave(att[(level)%10], level+1);
			}
		}

	}
	
}
