package com.display.Screens
{
	import com.data.Card;
	import com.data.Player;
	import com.display.Display;
	import com.display.GenericBt;
	
	public class SingleGameScreen extends AbstractScreen
	{
		private var stack			:Vector.<int>;
		private var players			:Vector.<Player>;
		private var c_details		:Vector.<CardDetails>;
		private var p_number		:int;
		private var indexPlaying	:int;
		private var turns			:int = 21;
		/**DISPLAY**/
		private var score			:GameScore;
		private var btCont			:GenericBt;
		
		public function SingleGameScreen(disp:Display, p_num:int)
		{
			super(disp);
			p_number = p_num;
			/*btCont = new GenericBt("Segue",next);
			btCont.x = display.background.width*0.5 - btCont.width;
			btCont.y = 700;*/
			start();
			starScore();
		}
		
		private function start():void
		{
			stack = new Vector.<int>();
			players = new Vector.<Player>();
			c_details = new Vector.<CardDetails>();
			var vec	:Vector.<Vector.<int>> = display.main.data.splitDeck(2);
			for (var i:int = 0; i < p_number; i++) 
			{
				var play:Player = new Player(i,true,vec[i]);
				players.push(play);
				var cards:CardDetails = new CardDetails(display.main.data.paramsNumber, this);
				cards.x = (display.background.width * 0.25) * i;
				cards.open(false,true);
				var card:Card = display.main.data.getCardById(players[i].cards[0]);
				cards.update(card.paramsNames,card.paramsValue,card.imgContainer);
				this.addChild(cards);
				c_details.push(cards);
			}
			indexPlaying = Math.floor(Math.random()*players.length);
			c_details[indexPlaying].open(true,false);
		}
		private function starScore():void
		{
			score = new GameScore();
			score.x = display.background.width*0.55 - score.width * 0.5;
			score.y = display.background.height*0.8;
			this.addChild(score);
		}
		public function updatePlayer():void
		{
			indexPlaying++;
			if (indexPlaying > players.length)
			{
				indexPlaying=0;
			}
		}
		public function compareParams(index:int):void
		{
			//c_details.addGlow(index);
			//c_details.open(false,false);
			//p_details.open(false,false);
		/*	var p_card:Card = display.main.data.getCardById(stack[0]);
			var c_card:Card = display.main.data.getCardById(stack[1]);
			var result:int = p_card.checkResult(index,int(c_card.paramsValue[index]));*/
			//trace (result);
			//score.showResult(result);
		}
		private function showResult(result:int):void
		{
			switch(result)
			{
				case 1:
					trace ("YOU WIN!");
					//player.push(stack);
					stack = new Vector.<int>();
					break;
				case 0:
					trace ("DRAW");
					break;
				case -1:
					trace ("YOU LOSE!");
					//ia.push(stack);
					stack = new Vector.<int>();
					break;
			}
			//score.update(player.length.toString(),ia.length.toString());
			this.addChild(btCont);
		}
		private function next():void
		{
			trace("SingleGameScreen.next()");
		}
	}
}