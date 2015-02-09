package com.hechoal.AleatoryTD.UI {
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Turrets.*
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class UIUpgrade extends Sprite{
		protected var ui:UIBox;
		protected var engine:Engine;
		protected var turret:Turret;
		public function getTurret():Turret{	return turret;}
		
		protected var btnWeapon:Sprite;
		protected var btnLevel:Sprite;
		protected var btnSell:Sprite;
		protected var btnWeaponTxt:TextField = new TextField();
		protected var btnSellTxt:TextField = new TextField();
		protected var btnLevelTxt:TextField = new TextField();
		
		protected var range:uint;
		protected var damage:uint;
		protected var level:uint;
		
		protected var titleTurretsTxt:TextField = new TextField();		
		protected var currTxt:TextField = new TextField();
		protected var futTxt:TextField = new TextField();
		
		protected var titleTurretsTf:TextFormat = new TextFormat();
		protected var statsTf:TextFormat = new TextFormat();
		protected var greenTf:TextFormat = new TextFormat();
		protected var redTf:TextFormat = new TextFormat();
		
		
		public function UIUpgrade(e:Engine, u:UIBox ) {
			engine = e;
			ui = u;
			
			initTitle();
			initStatFormat();
			initStatField(currTxt, 234, 21);			
			initStatField(futTxt, 234, 21);
			initBtns();
			
		}
		
		public function init(t:Turret){
			turret = t;
			
			setTitle();			
			setStats();
			
			setBtnSell();
			setBtnLevel();
			//setBtnWeapon();
			switch(_over){
				case 1: levelOver(null);break;
				case 2: trace("DAS"); //weaponOver(null);break;
				default: break;
			}
		}
		
		private function setBtnSell(){						
			btnSell.addEventListener(MouseEvent.CLICK, turret.sell);
			btnSell.addEventListener(MouseEvent.MOUSE_OVER, sellOver);
			btnSell.addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		private function setBtnLevel(){
			if(!turret.canLevelUp()){ 
				btnLevel.alpha = 0.5;
				if(turret.canLevel()){
					btnLevel.addEventListener(MouseEvent.MOUSE_OVER, levelOver);
				}
			}
			else {
				btnLevel.alpha = 1;	
				btnLevel.addEventListener(MouseEvent.CLICK, turret.levelup);
				btnLevel.addEventListener(MouseEvent.MOUSE_OVER, levelOver);
			}
			addChild(btnLevel);			
			btnLevel.addEventListener(MouseEvent.MOUSE_OUT, out);			
		}
		/*
		private function setBtnWeapon(){
			if(!turret.canWeaponUp()){
				btnWeapon.alpha = 0.5;
				if(turret.canWpnLevel()){
					btnWeapon.addEventListener(MouseEvent.MOUSE_OVER, weaponOver);
				}
			}
			
			else{//(turret.canWeaponUp()){
				btnWeapon.alpha = 1;
				btnWeapon.addEventListener(MouseEvent.CLICK, turret.weaponup);
				btnWeapon.addEventListener(MouseEvent.MOUSE_OVER, weaponOver);
			}
			
			addChild(btnWeapon);			
			btnWeapon.addEventListener(MouseEvent.MOUSE_OUT, out);
			
		}
		*/
		private var _over:uint = 0;
		public function levelOver(e:Event){
			/*if(turret.getLevel() == 9){
				_over = 2;
				setStats();
				futTxt.text = turret.getLevelText();
			}
			else{*/
				_over = 1;
				//setStats2();
				if(contains(currTxt))removeChild(currTxt);
				futTxt.text = "Range: "+turret.getRangeLevelup()
							+"\nDamage: "+turret.getDamageLevelup()
							+"\n" + turret.getLevelText()
							+"\nCOST: $" + turret.getLevelUpCost();
			//}			
			futTxt.setTextFormat(greenTf);
			addChild(futTxt);
		}
		
		/*public function weaponOver(e:Event){
			_over = 2;
			/*if(turret.getWeaponLevel() == 9){
				futTxt.text = turret.getWeapInfo();
			}
			else{
				futTxt.text = "\n" + turret.getLevelText()
						+"COST: $" + turret.getWeaponUpCost();
			//}
			
			futTxt.setTextFormat(greenTf);
			addChild(futTxt);
		}*/
		
		private function sellOver(e:Event){			
			futTxt.text = "\n\n\n\nSell for $" + turret.getSellVal().toString();
			futTxt.setTextFormat(redTf);
			addChild(futTxt);
		}
		
		public function out(e:Event){
			_over = 0;
			if(contains(futTxt)) removeChild(futTxt);
			addChild(currTxt);
			setStats();
		}
		
		
		public function unClickTurret(){
			turret.unClickTurret();
		}
		
		public function setStats(){
			range = turret.getRange();
			damage = turret.getDamage();			
			currTxt.text = "Range: " +range 
						+"\nDamage: "+damage
						+"\n"+turret.getWeapInfo();
			currTxt.setTextFormat(statsTf);
		}
		
		public function setStats2(){
			range = turret.getRange();
			damage = turret.getDamage();			
			currTxt.text = "Range: " +range 
						+"\nDamage: "+damage;
			currTxt.setTextFormat(statsTf);
		}
		
		public function setDamage(){
			
		}
		
		public function finalize(){
			btnSell.removeEventListener(MouseEvent.CLICK, turret.sell);
			btnSell.removeEventListener(MouseEvent.MOUSE_OVER, sellOver);
			btnSell.removeEventListener(MouseEvent.MOUSE_OUT, out);
			btnLevel.removeEventListener(MouseEvent.CLICK, turret.levelup);
			btnLevel.removeEventListener(MouseEvent.MOUSE_OVER, levelOver);
			btnLevel.removeEventListener(MouseEvent.MOUSE_OUT, out);
			//btnWeapon.removeEventListener(MouseEvent.CLICK, turret.weaponup);
			//btnWeapon.removeEventListener(MouseEvent.MOUSE_OVER, weaponOver);
			//btnWeapon.removeEventListener(MouseEvent.MOUSE_OUT, out);
			turret = null;
			if(contains(futTxt)) removeChild(futTxt);
			addChild(currTxt);
			if(contains(btnLevel)) removeChild(btnLevel);
			//if(contains(btnWeapon)) removeChild(btnWeapon);
		}		
		
		private function initBtns(){
			btnLevel = new MovieClip();
			btnLevel.graphics.lineStyle(1, 0x679541);
			btnLevel.graphics.beginFill(0x214818);
			btnLevel.graphics.drawRect(0,0,50,17);
			btnLevel.graphics.endFill();
			btnLevel.x = 376;
			btnLevel.y = 47;
			btnLevelTxt.selectable = false;
			btnLevelTxt.autoSize = TextFieldAutoSize.LEFT;
			btnLevelTxt.text = " Level up";
			btnLevelTxt.setTextFormat(statsTf);
			btnLevel.addChild(btnLevelTxt);
			addChild(btnLevel);
			
			/*
			btnWeapon = new MovieClip();
			btnWeapon.graphics.lineStyle(1, 0x679541);
			btnWeapon.graphics.beginFill(0x214818);
			btnWeapon.graphics.drawRect(0,0,50,17);
			btnWeapon.graphics.endFill();
			btnWeapon.x = 377;
			btnWeapon.y = 24;
			btnWeaponTxt.selectable = false;
			btnWeaponTxt.autoSize = TextFieldAutoSize.LEFT;
			btnWeaponTxt.x = 3;
			btnWeaponTxt.text = "Upgrade";
			btnWeaponTxt.setTextFormat(statsTf);
			btnWeapon.addChild(btnWeaponTxt);
			addChild(btnWeapon);
			*/
			
			btnSell = new MovieClip();
			btnSell.graphics.lineStyle(1, 0x693636);
			btnSell.graphics.beginFill(0x480000);
			btnSell.graphics.drawRect(0,0,50,17);
			btnSell.graphics.endFill();
			btnSell.buttonMode = true;
			btnSell.useHandCursor = true;
			btnSell.mouseChildren = false;
			btnSell.x = 376;
			btnSell.y = 70;
			btnSellTxt.selectable = false;
			btnSellTxt.autoSize = TextFieldAutoSize.LEFT;
			btnSellTxt.x = 13;
			btnSellTxt.text = "Sell";
			btnSellTxt.setTextFormat(statsTf);
			btnSell.addChild(btnSellTxt);
			addChild(btnSell);
		}
		
		private function initTitle(){
			titleTurretsTf.font = "Arial";
			titleTurretsTf.size = 12;
			titleTurretsTf.color = 0xCCCCCC;	
			titleTurretsTxt.x = 234;
			titleTurretsTxt.y = 4;
			titleTurretsTxt.selectable = false;
			//titleTurretsTxt.background = true;
			//titleTurretsTxt.backgroundColor = 0;
			titleTurretsTxt.autoSize = TextFieldAutoSize.LEFT;			
		}
		
		private function setTitle(){
			if(turret is TurretGreen) titleTurretsTxt.text = "Missile depot";
			else if(turret is TurretRed) titleTurretsTxt.text = "Laser array";
			else if(turret is TurretBlue) titleTurretsTxt.text = "Particle accelerator";
			else if(turret is TurretYellow) titleTurretsTxt.text = "Railgun";
			else if(turret is TurretCyan) titleTurretsTxt.text = "Gravity lab";
			else if(turret is TurretMagenta) titleTurretsTxt.text = "Radio detection and ranging";
			titleTurretsTxt.text = titleTurretsTxt.text.concat(" " + turret.getLevel());
			titleTurretsTxt.setTextFormat(titleTurretsTf);
			addChild(titleTurretsTxt);	
		}
		
		private function initStatFormat(){
			statsTf.font = "Arial";
			statsTf.size = 10;
			statsTf.color = 0xFFFFFF;
			greenTf.font = "Arial";
			greenTf.size = 10;
			greenTf.color = 0x55FF55;
			redTf.font = "Arial";
			redTf.size = 10;
			redTf.color = 0xFF5555;
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
