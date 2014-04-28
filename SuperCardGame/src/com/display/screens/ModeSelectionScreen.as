package com.display.screens
{
	import com.display.Display;
	import com.display.utils.AbstractScreen;
	import com.display.utils.GenericBt;
	import com.display.utils.TurnSlider;
	import com.greensock.TweenLite;
	
	import flash.events.MouseEvent;

	public class ModeSelectionScreen extends AbstractScreen
	{
		private var singlePlayer:GenericBt;
		private var multiPlayer	:GenericBt;
		private var turnSlider	:TurnSlider;
		public function ModeSelectionScreen(disp:Display)
		{
			super(disp);
			singlePlayer= new GenericBt(onSingleClicked,"", 163,247,display.main.data.getBMPById(7));
			singlePlayer.x = disp.background.width * 0.5 - singlePlayer.width * 1.8;
			singlePlayer.y = disp.background.height * 0.5 - singlePlayer.height * 0.48;
			singlePlayer.alpha = 0;
			this.addChild(singlePlayer);
			multiPlayer	= new GenericBt(onMultiClicked,"", 206,250,display.main.data.getBMPById(8));
			multiPlayer.y = singlePlayer.y;
			multiPlayer.x = singlePlayer.x + multiPlayer.width * 1.9;
			multiPlayer.alpha = 0;
			this.addChild(multiPlayer);
			makeTurnSlider();
			goAlpha();
		}
		
		private function makeTurnSlider():void
		{
			turnSlider = new TurnSlider(this);
			turnSlider.x = 440;
			turnSlider.y = 550;
			turnSlider.alpha = 0;
			this.addChild(turnSlider);
		}
		
		private function goAlpha():void
		{
			TweenLite.to(singlePlayer,1.5,{alpha:1});
			TweenLite.to(multiPlayer, 1.5,{alpha:1});
			turnSlider.show();
		}
		private function onMultiClicked(e:MouseEvent):void
		{
			display.goGame(2, false);
		}
		private function onSingleClicked(e:MouseEvent):void
		{
			display.goGame(2, true);
		}
		
		public function begin():void
		{
			goAlpha();
		}
		public function getTurns():int
		{
			return turnSlider.getTurnNumber();
		}
		public function close():void
		{
			singlePlayer.alpha = 0;
			multiPlayer.alpha = 0;
			turnSlider.hide();
		}
	}
}