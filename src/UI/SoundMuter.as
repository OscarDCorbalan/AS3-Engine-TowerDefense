package src.UI {
	
	import flash.display.SimpleButton;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.events.MouseEvent;
	
	public class SoundMuter extends SimpleButton {		
		
		private var muted:Boolean;		
		
		public function SoundMuter(xx:uint, yy:uint) {
			x = xx;
			y = yy;
			muted = false;
			setVol(100);
			addEventListener(MouseEvent.CLICK, muting, false, 0 , true);			
		}
		
		public function destroy(){
			removeEventListener(MouseEvent.CLICK, muting);
			setVol(0);
		}
		
		public function muting(event:MouseEvent){
			if(muted){
				alpha = 1;
				setVol(100);		
			}					
			else{
				alpha = 0.4;
				setVol(0);
			}			
			muted = !muted;
		}
		
		private function setVol(newVol : Number):void // use 0-100		
		{			
		  SoundMixer.soundTransform = new SoundTransform(newVol/100);		  
		}
	}
	
}
