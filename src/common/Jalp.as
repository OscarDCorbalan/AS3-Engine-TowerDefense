package src.common{
	import flash.events.MouseEvent;
	import flash.net.*;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;

	public class Jalp {

		public function Jalp() {}
		
		static public function addMenuButtons(_mc:Object){
			//addButtonFb(new fbButton(240,425),fbClick,_mc, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			//addButtonLg(new lgButton(276,425),lgClick,_mc, "http://x.mochiads.com/link/f31215bfa734d272");
		}
		static public function addMenuMapButtons(_mc:Object){
			//addButtonFb(new fbButton(30,171),fbClick,_mc, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			//addButtonLg(new lgButton(66,171),lgClick,_mc, "http://x.mochiads.com/link/f31215bfa734d272");
		}
		static public function addMenuLoadButtons(_mc:Object){
			//addButtonFb(new fbButton(240,308),fbClick,_mc, "http://x.mochiads.com/link/c7f3e5c9b631e5a2");
			//addButtonLg(new lgButton(275,308),lgClick,_mc, "http://x.mochiads.com/link/f31215bfa734d272");
		}
		static public function addGameOverButtons(_mc:Object){
			//addButtonFb(new fbButton(321,335),fbClick,_mc, "http://x.mochiads.com/link/d805d9f845090e9d");			
			//addButtonTw(new twButton(383,335),twClick,_mc, "http://x.mochiads.com/link/73a24cae836f0b02");
			//addButtonLg(new lgButton(357,335),lgClick,_mc, "http://x.mochiads.com/link/30e609f1814307d6");
		}
		static public function addButtonFb(btn:fbButton, clk:Function, _mc:Object, ml:String){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			//btn.makeButton(clk);
			//_mc.addChild(btn);
			//MochiServices.addLinkEvent(ml, "http://www.facebook.com/LoquatGames", btn);
		}		
		static public function addButtonTw(btn:twButton, clk:Function, _mc:Object, ml:String){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			//btn.makeButton(clk);
			//_mc.addChild(btn);
			//MochiServices.addLinkEvent(ml, "https://twitter.com/OscarDCorbalan", btn);
		}
		static public function addButtonLg(btn:lgButton, clk:Function, _mc:Object, ml:String){
			//var btn:MenuButton = new MenuButton(xx, yy, image);			
			//btn.makeButton(clk);
			//_mc.addChild(btn);
			//MochiServices.addLinkEvent(ml, "http://www.loquatgames.eu", btn);
		}
		static public function fbClick(myEvent:MouseEvent){
			//var request:URLRequest = new URLRequest("http://www.facebook.com/LoquatGames");
			//navigateToURL(request);
		}
		
		static public function twClick(myEvent:MouseEvent){
			//var request:URLRequest = new URLRequest("https://twitter.com/OscarDCorbalan");
			//navigateToURL(request);
		}
		
		static public function lgClick(myEvent:MouseEvent){
			//var request:URLRequest = new URLRequest("http://www.loquatgames.eu");
			//navigateToURL(request);
		}
		static public function getBitmapData( target:DisplayObject ):BitmapData
		{
			//target.width and target.height can also be replaced with a fixed number.
			var bd : BitmapData = new BitmapData( 550, 550 );
			bd.draw( target );
			return bd;
		}
		
		
	}
	
}
