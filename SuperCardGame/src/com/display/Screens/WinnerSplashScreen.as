package com.display.Screens
{
	import com.display.Display;
	import com.display.GenericBt;
	import com.greensock.TweenLite;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WinnerSplashScreen extends AbstractScreen
	{
		private var txt:TextField;
		private var winner:String;
		private var reset:GenericBt;
		public function WinnerSplashScreen(disp:Display, winnerName:String)
		{
			winner = winnerName;
			super(disp);
			start();
			bt();
		}
		
		private function bt():void
		{
			reset = new GenericBt(display.reset,"reset", 100,50,display.main.data.getBMPById(2));
			reset.x = display.background.width  * 0.2;
			reset.y = display.background.height * 0.2;
			this.addChild(reset);
		}
		
		private function start():void
		{
			txt = new TextField();
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = 26;
			/*txt.width = 300;
			txt.height = 150;*/
			txt.text = "E o vencedor é...";
			txt.background = true;
			txt.backgroundColor = 0xFFFFFF;
			txt.x = display.background.width*0.5;
			txt.y = display.background.height*0.5;
			txt.setTextFormat(txtFormat);
			this.addChild(txt);
			TweenLite.delayedCall(6,showName);
		}
		private function showName():void
		{
			txt.text += winner.toUpperCase();
		}
	}
}