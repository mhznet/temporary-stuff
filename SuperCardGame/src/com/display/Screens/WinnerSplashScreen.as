package com.display.Screens
{
	import com.display.Display;
	import com.display.GenericBt;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class WinnerSplashScreen extends AbstractScreen
	{
		private var card	:Sprite;
		private var tf		:TextField;
		private var winner	:String;
		private var w_cards	:int;
		private var reset	:GenericBt;
		private var share	:GenericBt;
		public function WinnerSplashScreen(disp:Display, winnerName:String, winnerCards:int)
		{
			winner = winnerName;
			w_cards = winnerCards;
			super(disp);
			bt();
			cardBegin();
		}
		
		private function cardBegin():void
		{
			card = new Sprite();
			var cardImg:Bitmap = new Bitmap();
			cardImg.bitmapData = display.main.data.getBMPById(3);
			var yellow:Bitmap = new Bitmap();
			tf = new TextField();
			var tfCards:TextField = new TextField();
			yellow.bitmapData = display.main.data.getBMPById(12);
			tf.text = "PARABÉNS! VOCE GANHOU O MATA MATA DAS SELEÇÕES!";
			tf.textColor = 0xFFFFFF;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.setTextFormat(getTextFormat(1));
			tf.height = 240;
			tf.width = 325;
			tf.border = false;
			tf.borderColor = 0x000000;
			tf.x = display.background.width * 0.5 - 190;
			tf.y = display.background.height * 0.3;
			tfCards.text = w_cards + " CARTAS!";
			tfCards.setTextFormat(getTextFormat(0));
			tfCards.textColor = 0xFFFFFF;
			tfCards.height = 100;
			tfCards.width = 250;
			cardImg.x = display.background.width * 0.5 + cardImg.width * 0.5;
			cardImg.y = display.background.height * 0.2 - 10;
			tfCards.x = cardImg.x + 10;
			tfCards.y = cardImg.y + cardImg.height;
			yellow.x = display.background.width * 0.3;
			yellow.y = display.background.height * 0.305;
			card.addChild(yellow);
			card.addChild(cardImg);
			card.addChild(tf);
			card.addChild(tfCards);
			card.mouseChildren = false;
			this.addChild(card);
		}
		
		private function bt():void
		{
			share = new GenericBt(null,"", 213,79,display.main.data.getBMPById(9));
			share.x = display.background.width  * 0.1 - 35;
			share.y = display.background.height * 0.305;
			this.addChild(share);
			
			reset = new GenericBt(display.reset,"", 213,79,display.main.data.getBMPById(11));
			reset.x = share.x;
			reset.y = share.y + reset.height + 15;
			this.addChild(reset);
		}
	}
}