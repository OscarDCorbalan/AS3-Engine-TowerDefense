package src.UI {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import src.Engine.*;	
	import src.Engine.Turrets.Turret;
	
	public class UIBox extends MovieClip{
		protected var titleTurretsTxt:TextField = new TextField();
		protected var titleTurretsTf:TextFormat = new TextFormat();
		
		protected var ctentTurretsTxt:TextField = new TextField();
		protected var ctentTurretsTf:TextFormat = new TextFormat();
		
		protected var upg:UIUpgrade;
		protected var stats:UIStats;
		
		protected var tgreen:UITurretGreen;
		protected var tred:UITurretRed;
		protected var tblue:UITurretBlue;
		protected var tcyan:UITurretCyan;
		protected var tyellow:UITurretYellow;
		protected var tmagenta:UITurretMagenta;
		
		protected var currWave:UIEnemy;
		protected var nextWave:UIEnemy;
		protected var engine:Engine;
		private var autobut:AutoButton;
		private var soundMuter:SoundMuter;
		private var speedometer:Speedometer;
		private var xtender:Xtend;
		
		public function UIBox(e:Engine, ml:uint, turrets:XMLList = null) {
			
			engine = e;
			stats = new UIStats(e, this, ml);
			upg = null;
			addChild(stats);
			initTextFields();	
			createTurretsUI(turrets);
			
			
			addEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
		}
		
		
		private function doAddLinkEvent(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,doAddLinkEvent);
					
			
			
			autobut = new AutoButton(engine);
			autobut.x = 451;
			autobut.y = 77;
			addChild(autobut);
			
			var qb:QuitButton = new QuitButton();
			qb.x = 258;
			qb.y = 131;
			qb.addEventListener(MouseEvent.CLICK, engine.quitToMenu,false,0,true);
			addChild(qb);
			
			//addButtonFb(new fbButton(15,120), fbClick);
			//addButtonTw(new twButton(79,120), twClick);
			//addButtonLg(new lgButton(47,120), lgClick);
			addSpeedometer(15,120);
			addMuter(55,120);			
			addXtender(90,120);
		}
		
		
		
		public function getUIStats(){
			return stats;
		}
		
		private function initTextFields(){
			titleTurretsTf.font = "Arial";
			titleTurretsTf.size = 12;
			titleTurretsTf.color = 0xCCCCCC;		
			ctentTurretsTf.font = "Arial";
			ctentTurretsTf.size = 10;
			ctentTurretsTf.color = 0xEEEEEE;	
			
			titleTurretsTxt.x = 234;
			titleTurretsTxt.y = 5;
			titleTurretsTxt.selectable = false;
			//titleTurretsTxt.background = true;
			//titleTurretsTxt.backgroundColor = 0;
			titleTurretsTxt.autoSize = TextFieldAutoSize.LEFT;
			ctentTurretsTxt.x = 234;
			ctentTurretsTxt.y = 21;
			ctentTurretsTxt.selectable = false;
			ctentTurretsTxt.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function createTurretsUI(xmlList:XMLList){
			var xml = new XML(xmlList);
			upg = new UIUpgrade(engine, this);
			
			tred = new UITurretRed(engine,this,xml.Red);
			addChild(tred);
			tred.x = 16;
			tred.y = 29;
			
			tgreen = new UITurretGreen(engine,this,xml.Green);
			addChild(tgreen);
			tgreen.x = 47;
			tgreen.y = 29;			
			
			tblue = new UITurretBlue(engine,this,xml.Blue);
			addChild(tblue);
			tblue.x = 78;
			tblue.y = 29;
			
			tcyan = new UITurretCyan(engine,this,xml.Cyan);
			addChild(tcyan);
			tcyan.x = 16;
			tcyan.y = 59;
			
			tmagenta = new UITurretMagenta(engine,this,xml.Magenta);
			addChild(tmagenta);
			tmagenta.x = 47;
			tmagenta.y = 59;
			
			tyellow = new UITurretYellow(engine,this,xml.Yellow);
			addChild(tyellow);
			tyellow.x = 78;
			tyellow.y = 59;
		}
		
		private function setTitle(t:String){
			titleTurretsTxt.text = t;
			titleTurretsTxt.setTextFormat(titleTurretsTf);
			addChild(titleTurretsTxt);	
		}

		private function setContent(t:String){
			ctentTurretsTxt.text = t;
			ctentTurretsTxt.setTextFormat(ctentTurretsTf);
			addChild(ctentTurretsTxt);	
		}
		
		public function overTBlue(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Particle accelerator");
			setContent(tblue.getText());
		}
		
		public function overTGreen(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Missile depot");
			setContent(tgreen.getText());
		}
		
		public function overTRed(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Laser array");
			setContent(tred.getText());
		}
		
		public function overTCyan(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Gravity lab");
			setContent(tcyan.getText());
		}
		
		public function overTMagenta(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Radio detection and ranging");
			setContent(tmagenta.getText());
		}
		
		public function overTYellow(e:MouseEvent){
			if(upg!=null && contains(upg)) return;
			setTitle("Railgun");
			setContent(tyellow.getText());
		}
		
		public function outTurret(e:MouseEvent){
			//setTxt("");
			if(contains(titleTurretsTxt)) removeChild(titleTurretsTxt);
			if(contains(ctentTurretsTxt)) removeChild(ctentTurretsTxt);	
			addChild(stats);
		}
				
		public function overLevel(){
			upg.levelOver(null);
		}
		
		/*public function overWeapon(){
			upg.weaponOver(null);
		}*/
		
		public function outLevel(){
			upg.out(null);
		}
		public function overStats(){
			//upg.statsOver(null);
		}
		
		public function clearUI(){
			if(contains(upg)){
				upg.unClickTurret();
				removeUpg();
			}
			addChild(stats);
		}
		
		public function clickTower(t:Turret){
			if(upg.getTurret() == t) return;
			
			if(contains(upg)) {
				upg.unClickTurret();
				removeUpg();
			}			
			upg.init(t);
			addChild(upg);			
		}		
		public function removeUpg(){
			if(contains(upg)) {
				removeChild(upg);
				upg.finalize();
			}
		}		
		public function setCurrentWave(type:uint, level:uint){
			//currWave = null;
			currWave = new UIEnemy(engine, this, type,level);
			currWave.x=439;
			currWave.y=8;
			currWave.alpha = 1;
			addChild(currWave);
		}
		
		public function setNextWave(type:uint, level:uint){
			//nextWave = null;
			nextWave = new UIEnemy(engine, this, type, level, level==1);
			nextWave.x=439;
			nextWave.y=86;
			addChild(nextWave);
		}
		
		public function activateNextWave(){
			if(nextWave != null && !nextWave.activated() && contains(nextWave)){
				nextWave.activate();
			}
		}
		
		public function sendNextWave(){
			if(nextWave != null){
				removeChild(nextWave);
				nextWave = null;
			}
			if(currWave != null){
				removeChild(currWave);
				currWave = null;
			}
			engine.sendNextWave();
		}
		
		public function getStatsRef():UIStats{
			return stats;
		}
		
		public function refreshUITurrets(_m:uint){
			if(upg.getTurret() != null){
				upg.init(upg.getTurret());
			}
			if(_m < tgreen.price) tgreen.deactivate();
			else tgreen.activate();
			if(_m < tred.price) tred.deactivate();
			else tred.activate();
			if(_m < tblue.price) tblue.deactivate();
			else tblue.activate();
			if(_m < tcyan.price) tcyan.deactivate();
			else tcyan.activate();
			if(_m < tyellow.price) tyellow.deactivate();
			else tyellow.activate();
			if(_m < tmagenta.price) tmagenta.deactivate();
			else tmagenta.activate();
		}
				
		private function addMuter(xx:uint, yy:uint){
			soundMuter = new SoundMuter(xx,yy);
			addChild(soundMuter);
		}
		private function addSpeedometer(xx:uint, yy:uint){
			speedometer = new Speedometer(xx,yy);
			addChild(speedometer);
		}
		private function addXtender(xx:uint, yy:uint){
			xtender = new Xtend(xx,yy,engine);
			addChild(xtender);
		}
		public function destroy(){
			speedometer.destroy();
			removeChild(soundMuter);
			soundMuter.destroy();
			soundMuter = null;
			removeChild(titleTurretsTxt);
			removeChild(ctentTurretsTxt);
			titleTurretsTxt = null;
			titleTurretsTf = null;
			ctentTurretsTxt = null;
			ctentTurretsTf = null;
			if(contains(upg)) removeChild(upg);
			upg = null;
			if(contains(stats)) removeChild(stats);
			stats = null;
			removeChild(tgreen);
			removeChild(tred);
			removeChild(tblue);
			removeChild(tcyan);
			removeChild(tyellow);
			removeChild(tmagenta);
			tgreen = null;
			tred = null;
			tblue = null;
			tcyan = null;
			tyellow = null;
			tmagenta = null;
			if(contains(currWave)) removeChild(currWave);
			currWave = null;
			if(contains(nextWave)) removeChild(nextWave);
			nextWave = null;
			engine = null;
			removeChild(autobut);
			autobut = null;	
		
		}
		public function setInfinite(){
			stats.setInfinite();
		}
		
		public function clickUITurret(tc:uint):void{
			switch(tc){
				case 1:
					tred.clickUITurret();
					break;
				case 2:
					tgreen.clickUITurret();
					break;
				case 3:
					tblue.clickUITurret();
					break;
				case 4:
					tcyan.clickUITurret();
					break;
				case 5:
					tmagenta.clickUITurret();
					break;
				case 6:
					tyellow.clickUITurret();
					break;	
			}
			
		}
		
	}
	
}
