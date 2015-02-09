package com.hechoal.AleatoryTD.Turrets{//creating the basic skeleton
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.UI.UIBox;
	import com.hechoal.AleatoryTD.Enemies.Enemy;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Shape;
	
	
	public class Turret extends Sprite{
		
		protected var ui:UIBox;	
		protected var sprite:Sprite = new Sprite();
		protected var _b:Bitmap;
		
		protected var cEnemy;
		protected var enTarget:Enemy;
		protected var newBullet;
		
		protected var cTime:uint = 0;
		protected var loaded:Boolean = true;
		
		protected var level:uint;
		protected var maxlevel:uint;
		//protected var wpnlevel:uint;
		//protected var maxwpnlevel:uint;
		
		protected var damage:uint;
		protected var range:uint;
		protected var reloadTime:uint;	
		
		protected var i:uint;
		protected var j:uint;
		protected var k:uint;
		
		protected var enDist:Number;
		
		protected var val:uint;
		protected var price:uint;
		
		//levelup		
		protected var baseDmg:uint;
		protected var baseRng:uint;
		protected var rngInc:uint;
		protected var dmgInc:uint;
		protected var rngMult:Number = 1;
		
		public function Turret(u:UIBox, image:Bitmap){
			ui = u;
			level = 1;
			maxlevel = 9;
			
			buttonMode = true;
			
			image.x -= image.width/2;
			image.y -= image.height/2;			
			sprite.addChild(image);
			addChild(sprite);
			image = null;

			mouseChildren = true;
			addEventListener(Event.ADDED_TO_STAGE, added);
			
		}
		
		
		protected function added(e:Event){
			var _w:Boolean,
				_h:Boolean;
			for(i = 0; i < MovieClip(parent.parent).turretHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).turretHolder.getChildAt(i);
				_w = false;
				_h = false;

				if(cEnemy is TurretMagenta){
					if(cEnemy.y - y == -25 || cEnemy.y - y == 25 || cEnemy.y - y == 0){
						_h = true;
						if(cEnemy.x - x == -25 || cEnemy.x - x == 25 || x - cEnemy.x == 0) _w = true;
					}
					if(_h && _w){
						cEnemy.linkMe(this);
					}
				}
			}
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		
		protected function eFrameEvents(e:Event):void{
 
		}
		
		public function sell(e:Event){
			removeEventListener(Event.ENTER_FRAME, eFrameEvents);					
			MovieClip(parent.parent).addMoney(getSellVal());
			
			var _w:Boolean,
				_h:Boolean;			
			for(i = 0; i < MovieClip(parent.parent).turretHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).turretHolder.getChildAt(i);
				_w = false;
				_h = false;
				
				if(cEnemy != this && cEnemy is TurretMagenta){
					if(cEnemy.y - y == -25 || cEnemy.y - y == 25 || cEnemy.y - y == 0){
						_h = true;
						if(cEnemy.x - x == -25 || cEnemy.x - x == 25 || x - cEnemy.x == 0) _w = true;
					}
					if(_h && _w){
						cEnemy.unLinkMe(this);
					}
				}
			}
			
			clean();			
		}
		
		protected function finalize(){
			removeEventListener(Event.ENTER_FRAME, eFrameEvents);
			Sprite(parent).removeChild(this);
			ui = null;
			cEnemy = null;
			enTarget = null;
			sprite.removeChildAt(0);
			removeChild(sprite);
			sprite = null
			newBullet = null;
		}
		
		public function getLevelUpCost():uint{
			trace("super");
			return price * 1.5;
		}
		/*public function getWeaponUpCost():uint{
			return price;
		}*/
		protected function levelUpCommon(){
			damage = getDamageLevelup();
			
			range = getRangeLevelup();
			
			ui.getStatsRef().subMoney(getLevelUpCost());			
			val += getLevelUpCost();
			level++;
			
			ui.clearUI();
			clickTurret();
			if(canLevelUp()) ui.overLevel();
			else ui.outLevel();			
		}
		
		protected function weaponUpCommon(_b:Bitmap){
			_b.x -= _b.width/2;
			_b.y -= _b.height/2;
			sprite.removeChildAt(0);
			sprite.addChild(_b);
			_b = null;			
		}
		
		
		protected function clean(){
			
		}
		public function levelup(e:Event){
			levelUpCommon();
		}
		public function weaponup(e:Event){
			
		}

		public function getLevelText():String{
			return "Error. Turret not subclassed."
		}
		
		public function clickTurret(){
			graphics.clear();
			graphics.lineStyle(1,0xEEEEEE);
			graphics.drawCircle(0,0,range);
			Sprite(parent).addChild(this);
			ui.clickTower(this);			
		}
		
		public function unClickTurret(){
			graphics.clear();
		}
		
		public function getRange():Number{
			return range;
		}
		public function getDamage():uint{
			return damage;
		}
		public function getLevel():uint{
			return level;
		}
		/*public function getWeaponLevel():uint{
			return wpnlevel;
		}*/
		public function getSellVal():uint{
			return val * 0.75;
		}
		public function getReloadTime(){
			return reloadTime;
		}
		
		public function getDamageLevelup():uint{
			return baseDmg + level*dmgInc;
		}
		public function getRangeLevelup():uint{			
			return (baseRng + level*rngInc) * rngMult;
		}
		public function subRangeMult(_r:Number){			
			rngMult -= _r;
			range = (baseRng + (level-1)*rngInc) * rngMult;
		}
		public function addRangeMult(_r:Number){			
			rngMult += _r;
			range = (baseRng + (level-1)*rngInc) * rngMult;
		}
		
		var _chosen:Number;
		var _tmp:Number;
		protected function nearEnemy(){
			_chosen = range;
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
				if(_tmp < _chosen){
					enTarget = cEnemy;
					_chosen = _tmp;
				}
			}
		}
		
		protected function fastEnemy(){			
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
				if(_tmp < range)
					break;
			}
			if(i >= MovieClip(parent.parent).enemyHolder.numChildren)
				return;
				
			enTarget = cEnemy;
			i++;
			for(; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
				if(_tmp < range && cEnemy.maxSpeed > enTarget.maxSpeed){
					enTarget = cEnemy;
				}
			}
		}
		
		protected function hardEnemy(){
			
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
				if(_tmp < range)
					break;
			}
			if(i >= MovieClip(parent.parent).enemyHolder.numChildren)
				return;
				
			enTarget = cEnemy;
			i++;
			for(; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
				if(_tmp < range && cEnemy.health > enTarget.health){
					enTarget = cEnemy;
				}
			}
		}
		
		protected function outRange(){
			if(enTarget == null) return true;
			if(enTarget.health <= 0) return true;			
			if(Math.sqrt(Math.pow(enTarget.y - y+12.5, 2) + Math.pow(enTarget.x - x+12.5, 2)) >= range) return true;			
		}
		
		public function canLevelUp():Boolean{
			if(getLevelUpCost() > ui.getStatsRef().getMoney() ) return false;
			if(level < maxlevel) return true;
			return false;
		}
		/*public function canWeaponUp():Boolean{
			if(price > ui.getStatsRef().getMoney() ) return false;
			if(wpnlevel < maxwpnlevel) return true;
			return false;
		}*/
		public function getWeapInfo():String{
			return "Error. Turret not subclassed."
		}
		/*public function canWpnLevel():Boolean{
			return wpnlevel < maxwpnlevel;
		}*/
		public function canLevel():Boolean{
			return level < maxlevel;
		}
	}
}