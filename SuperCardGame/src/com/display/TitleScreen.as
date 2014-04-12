package com.display
{
	import com.display.Screens.AbstractScreen;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	public class TitleScreen extends AbstractScreen
	{
		public var bg		:Bitmap;
		public var regras	:GenericBt;
		public var play		:GenericBt;
		public function TitleScreen(disp:Display)
		{
			super(disp);
			start();
		}
		private function start():void
		{
			bgReady();
			bts();
		}
		public function bgReady():void
		{
			bg = new Bitmap();
			bg.bitmapData = display.main.data.getBMPById(5).clone();
			this.addChild(bg);
		}
		public function bts():void
		{
			play = new GenericBt(goPlay,"", 140,70,display.main.data.getBMPById(1));
			play.x = display.background.width*0.63;
			play.y = display.background.height*0.6;
			play.alpha = 0;
			this.addChild(play);
			regras = new GenericBt(goRules,"",140,70, display.main.data.getBMPById(6));
			regras.x = play.x + 20 + regras.width;
			regras.y = play.y;
			regras.alpha =0;
			this.addChild(regras);
			tween()
		}
		
		private function tween():void
		{
			TweenLite.to(regras,1,{delay:1,alpha:1});
			TweenLite.to(play,1,{delay:0.5,alpha:1});
		}
		private function goPlay(e:MouseEvent):void
		{
			display.goModeSelect();
		}
		private function goRules(e:MouseEvent):void
		{
			//GORULS
		}
	}
}