package com.display.Screens
{
	import com.data.Card;
	import com.data.Player;
	import com.display.Display;
	import com.display.GenericBt;
	import com.greensock.TweenLite;
	
	import flash.events.MouseEvent;
	
	public class SingleGameScreen extends AbstractScreen
	{
		private var stack			:Vector.<int>;
		private var oldStack		:Vector.<int>;
		private var players			:Vector.<Player>;
		private var c_details		:Vector.<CardDetails>;
		private var p_number		:int;
		private var nextBt			:GenericBt;
		private var hasIA			:Boolean;
		private var indexPlaying	:int;
		private var turns			:int;
		/**DISPLAY**/
		private var score			:GameScore;
		
		public function SingleGameScreen(disp:Display, p_num:int, ia:Boolean)
		{
			super(disp);
			begin(p_num, 0, ia);
		}
		
		public function begin(p_num:int, turnTotal:int, ia:Boolean):void
		{
			hasIA = ia;
			if(hasIA)showNextBt();
			p_number = p_num;
			turns = turnTotal;
			startScore();
			start();
		}
		
		private function showNextBt():void
		{
			nextBt = new GenericBt(selecIA,"NEXT",100,50,display.main.data.getBMPById(2));
			nextBt.x = display.background.width * 0.5 - nextBt.width * 0.5;
			nextBt.y = display.background.height - nextBt.height * 2;
			nextBt.visible = false;
			this.addChild(nextBt);
		}
		
		private function selecIA(e:MouseEvent):void
		{
			nextBt.visible = false;
			c_details[1].dispatchOn();
		}
		
		private function start():void
		{
			stack = new Vector.<int>();
			oldStack = new Vector.<int>();
			players = new Vector.<Player>();
			c_details = new Vector.<CardDetails>();
			var vec	:Vector.<Vector.<int>> = display.main.data.splitDeck(p_number);
			for (var i:int = 0; i < p_number; i++)
			{
				var playable:Boolean = true;
				if (hasIA && i != 0) playable = false;
				var play	:Player = new Player(i,playable,vec[i]);
				players.push(play);
				var cards	:CardDetails = new CardDetails(display.main.data.paramsNumber, this);
				cards.x = 60 + (display.background.width * 1.15 * i) / p_number;
				cards.y = 110;
				var card	:Card = display.main.data.getCardById(players[i].cards[0]);
				cards.update(card.paramsNames,card.paramsValue,card.imgContainer, playable);
				cards.id = i;
				cards.close(true);
				this.addChild(cards);
				c_details.push(cards);
			}
			score.update(players);
			indexPlaying = Math.floor(Math.random()*players.length);
			if (hasIA&&indexPlaying==1)nextBt.visible = true;
			c_details[indexPlaying].close(false);
			c_details[indexPlaying].open();
		}
		public function showNewCard():void
		{
			for (var i:int = 0; i < p_number; i++) 
			{
				if (players[i].cards.length > 0)
				{
					var card	:Card = display.main.data.getCardById(players[i].cards[0]);
					var playable:Boolean = true;
					if (hasIA && i != 0) playable = false;
					c_details[i].update(card.paramsNames,card.paramsValue,card.imgContainer, playable);
					c_details[i].close(true);
				}
			}
			c_details[indexPlaying].close(false);
			c_details[indexPlaying].open();
			if (hasIA && indexPlaying == 1) 
			{
				nextBt.visible = true
			}
			else
			{
				nextBt.visible = false;
			}
		}
		private function startScore():void
		{
			score = new GameScore(p_number);
			score.x = display.background.width * 0.5 - score.width * 0.5;
			score.y = display.background.height - score.height * 0.6;
			this.addChild(score);
		}
		public function compareParams(index:int):void
		{
			var playerIndex:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < players.length; i++) 
			{
				c_details[i].close(false);
				c_details[i].addGlow(index);
				var p_card:Card = display.main.data.getCardById(players[i].cards[0]);
				players[i].cards.splice(0,1);
				stack.push(p_card.id);
				playerIndex.push(p_card.paramsValue[index]);
			}
			trace ("Valores em ordem:", playerIndex);
			var winningPlayerIndex:int = returnBiggestIndex(playerIndex);
			var ordenado:Vector.<int> = bubble(playerIndex);
			if (ordenado[0] == ordenado[1])
			{
				trace ("VALORES IGUAIS, NEXT PLS");
				oldStack = oldStack.concat(stack);
				stack.splice(0,stack.length);
				//FEEDBACK
				/*for (var k:int = 0; k < c_details.length; k++) 
				{
					c_details[k].glowRed();
				}*/
				TweenLite.delayedCall(2.5,next);
				score.update(players);
			}
			else
			{
				trace ("player"+winningPlayerIndex,"é o vencedor!, ganha:", oldStack.length, stack.length);
				players[winningPlayerIndex].cards = players[winningPlayerIndex].cards.concat(oldStack,stack);
				//c_details[winningPlayerIndex].blinkGlow();
				c_details[winningPlayerIndex].removeBlink(false);
				TweenLite.delayedCall(3,next);
				stack.splice(0,stack.length);		
				oldStack.splice(0,oldStack.length);
				indexPlaying = winningPlayerIndex;
				score.update(players);
			}
			for (var j:int = 0; j < players.length; j++) 
			{
				trace("Player"+j,"tem",players[j].cards.length,"cartas.");
			}
		}
		private function bubble(vec:Vector.<int>):Vector.<int>
		{
			for (var bubbleSort:int = vec.length; bubbleSort >= 0; bubbleSort--)
			{
				for (var jota:int = 1; jota < bubbleSort; jota++)
				{
					var aux:int;
					if (vec[jota] > vec[jota - 1])
					{
						aux = vec[jota - 1];
						vec[jota - 1] = vec[jota];
						vec[jota] = aux;	
					} 
				}
			}
			return vec;
		}
		private function returnBiggestIndex(value:Vector.<int>):int
		{
			var winningIndex	:int = 0;
			var winningValue	:int = -1;
			for (var i:int = 0; i < value.length; i++) 
			{
				if (value[i] > winningValue)
				{
					winningIndex = i;
					winningValue = value[i];
				}
			}
			return winningIndex;
		}
		public function next():void
		{
			var endGame:Boolean = false;
			for (var i:int = 0; i < players.length; i++) 
			{
				if (players[i].cards.length == 0)
					endGame = true;
			}
			if (!endGame) 
			{
				showNewCard();
			}
			else
			{
				display.goToWinner("Player_"+getActualWinner());
			}
		}
		
		private function getActualWinner():int
		{
			var index:int;
			var biggerLength:int = 0;
			for (var i:int = 0; i < players.length; i++) 
			{
				if(players[i].cards.length > biggerLength)
				{
					biggerLength = players[i].cards.length;
					index = i;
				}
			}
			trace ("getActualWinner:", index,"com", biggerLength,"cards.");
			return index;
		}
		
		public function reset():void
		{
			for (var i:int = 0; i < players.length; i++) 
			{
				players[i].destroy();
				players[i]	= null;
				c_details[i].destroy();
				c_details[i]= null;
			}
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			c_details 	= null;
			players		= null;
			stack		= null;
			oldStack	= null;
			p_number	= 0;
			indexPlaying= 0;
			score.destroy();
		}
	}
}