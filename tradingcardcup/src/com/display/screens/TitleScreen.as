package com.display.screens
{
	import com.display.MainDisplay;
	import flash.events.MouseEvent;
	
	public final class TitleScreen extends AbstractScreen
	{
		public var btPlay		:GenericBt;
		public var btContinue	:GenericBt;
		public function TitleScreen(disp:MainDisplay)
		{
			super(disp);
			initializaBtPlay();
			initializaBtContinue();
		}
		private function initializaBtPlay():void
		{
			if (!btPlay)
			{
				btPlay = new GenericBt();
				btPlay.text.text = "PLAY";
				btPlay.mouseChildren = false;
				btPlay.x = display.background.width * 0.5;
				btPlay.y = display.background.height * 0.8;
				btPlay.addEventListener(MouseEvent.CLICK, display.gotoSelectCards);
				btPlay.buttonMode = true;
				this.addChild(btPlay);
			}
			else if (this.contains(btPlay))
			{
				this.removeChild(btPlay);
			}
		}
		private function initializaBtContinue():void
		{
			if (!btContinue)
			{
				btContinue = new GenericBt();
				btContinue.mouseChildren = false;
				btContinue.text.text = "CONT.";
				btContinue.alpha = 0.5;
				btContinue.x = display.background.width * 0.5;
				btContinue.y = display.background.height * 0.8 - btContinue.height;
				//btContinue.addEventListener(MouseEvent.CLICK, display.gotoSelectCards);
				//btContinue.buttonMode = true;
				this.addChild(btContinue);
			}
			else if (this.contains(btContinue))
			{
				this.removeChild(btContinue);
			}
		}
	}
}