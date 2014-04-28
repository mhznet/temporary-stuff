package com.display.screens
{
	import com.display.Display;
	import com.display.utils.AbstractScreen;
	import com.display.utils.GenericBt;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class WinnerSplashScreen extends AbstractScreen
	{
		private var card			:Sprite;
		private var yCont			:Sprite;
		private var yContMask		:Sprite;
		private var tf				:TextField;
		private var winner			:String;
		private var winnerIndex		:int;
		private const WINNER_TEXT_1	:String = "PARABÉNS! ";
		private const WINNER_TEXT_2	:String = " GANHOU O MATA MATA DAS SELEÇÕES!";
		private const LOST_TEXT		:String = "UMA PENA! VOCÊ PERDEU O MATA MATA DAS SELEÇÕES!";
		private const DRAW_TEXT		:String = "ACABOU! SEM MAIS TURNOS, FICOU TUDO NO EMPATE!";
		private var w_cards			:int;
		private var reset			:GenericBt;
		private var share			:GenericBt;
		public var yellow			:Bitmap;
		public var tfCards			:TextField;
		public var hasIA			:Boolean;
		public var play_status		:int;
		
		public function WinnerSplashScreen(disp:Display, winLostOrDraw:int, wIndex:int, winnerCards:int, ia:Boolean)
		{
			super(disp);
			bt();
			cardBegin();
			begin(winLostOrDraw,wIndex,winnerCards, ia);
		}
		
		public function begin(w:int,index:int,cardN:int,ias:Boolean):void
		{
			this.winnerIndex = index;
			hasIA = ias;
			play_status = w;
			switch(w)
			{
				case -1:
					winner = LOST_TEXT;
					break;
				case 0:
					winner = DRAW_TEXT;
					break;
				case 1:
					winner = getWinTextWithIndex();
					break;
			}
			w_cards = cardN;
			tfCards.text = w_cards + " CARTAS!";
			tfCards.setTextFormat(getTextFormat(0));
			tf.text = winner;
			tf.setTextFormat(getTextFormat(1));
			showBts();
		}
		
		public function close():void
		{
			share.alpha=0;
			reset.alpha=0;
			tfCards.alpha=0;
			yCont.x = display.background.width * 0.3 + yCont.width;
		}
		
		private function showBts():void
		{
			TweenLite.to(yCont, 1, {x:display.background.width * 0.3, ease:Back.easeOut, onComplete:showPlayAgain});
		}
		private function showPlayAgain():void
		{
			TweenLite.to(share,0.8,{alpha:1});
			TweenLite.to(reset,0.8,{alpha:1});
			if (winner!=DRAW_TEXT)TweenLite.to(tfCards,0.8,{alpha:1});
		}
		private function getWinTextWithIndex():String
		{
			var returns:String;
			if (hasIA)
			{
				returns = WINNER_TEXT_1 + "você" + WINNER_TEXT_2;
			}
			else
			{
				returns = WINNER_TEXT_1 + "Player "+ winnerIndex + WINNER_TEXT_2;
			}
			return returns;
		}
		private function cardBegin():void
		{
			card = new Sprite();
			yCont = new Sprite();
			yContMask = new Sprite();
			var mask:Shape = new Shape();
			mask.graphics.beginFill(0x000000,1);
			mask.graphics.drawRect(0,0,400,240);
			mask.graphics.endFill();
			yContMask.addChild(mask);
			var cardImg:Bitmap = new Bitmap();
			cardImg.bitmapData = display.main.data.getBMPById(3);
			yellow= new Bitmap();
			tf = new TextField();
			tfCards= new TextField();
			yellow.bitmapData = display.main.data.getBMPById(12);
			tf.textColor = 0xFFFFFF;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.height = 260;
			tf.width = 320;
			tf.border = false;
			tf.borderColor = 0x000000;
			tf.x = /*display.background.width * 0.5 - 190*/-10;
			tf.y = /*display.background.height * 0.3*/10;
			tfCards.textColor = 0xFFFFFF;
			tfCards.height = 100;
			tfCards.width = 250;
			cardImg.x = display.background.width * 0.5 + cardImg.width * 0.5;
			cardImg.y = display.background.height * 0.2 - 10;
			tfCards.x = cardImg.x + 10;
			tfCards.y = cardImg.y + cardImg.height;
			yCont.addChild(yellow);
			yCont.addChild(tf);
			yCont.x = display.background.width * 0.3 + yCont.width;
			yCont.y = display.background.height * 0.305;
			yContMask.x = display.background.width * 0.25;
			yContMask.y = yCont.y;
			card.addChild(yCont);
			yCont.mask = yContMask;
			card.addChild(yContMask);
			card.addChild(cardImg);
			card.addChild(tfCards);
			tfCards.alpha = 0;
			card.mouseChildren = false;
			this.addChild(card);
		}
		private function bt():void
		{
			share = new GenericBt(facebookShare,"", 213,79,display.main.data.getBMPById(9));
			share.x = display.background.width  * 0.1 - 35;
			share.y = display.background.height * 0.305;
			share.alpha = 0;
			
			reset = new GenericBt(display.reset,"", 213,79,display.main.data.getBMPById(11));
			reset.x = share.x;
			reset.y = share.y + reset.height + 15;
			reset.alpha = 0;
			
			this.addChild(share);
			this.addChild(reset);
		}
		private function facebookShare(e:MouseEvent):void
		{
			//Aqui shareia no face!
			switch(play_status)
			{
				case -1://Perdeu
					break;
				case 0://Empatou
					break;
				case 1://Algum dos players ganhou, P1 ou P2, se tiver IA (hasIA) foi p1, se não ver o winnerIndex.
					break;
			}
		}
	}
}