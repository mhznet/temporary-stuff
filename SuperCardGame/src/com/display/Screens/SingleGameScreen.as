package com.display.Screens
{
	import com.data.Card;
	import com.data.Player;
	import com.display.utils.CardShuffleAnimation;
	import com.display.Display;
	import com.display.utils.GenericBt;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.display.utils.AbstractScreen;
	
	public class SingleGameScreen extends AbstractScreen
	{
		private var container		:Sprite;
		private var stack			:Vector.<int>;
		private	var oldStack		:Vector.<int>;
		private var players			:Vector.<Player>;
		private var c_details		:Vector.<CardDetails>;
		public var p_number			:int;
		private var nextBt			:GenericBt;
		private var hasIA			:Boolean;
		private var indexPlaying	:int;
		public var turns			:int;
		/**DISPLAY**/
		private var score			:GameScore;
		private var shuffle			:CardShuffleAnimation;
		
		public function SingleGameScreen(disp:Display, p_num:int, ia:Boolean)
		{
			super(disp);
			container = new Sprite();
			this.addChild(container);
			begin(p_num, display.turns, ia);
		}
		
		public function begin(p_num:int, turnTotal:int, ia:Boolean = false):void
		{
			hasIA = ia;
			if(hasIA)showNextBt();
			p_number = p_num;
			turns = turnTotal;
			shuffle = new CardShuffleAnimation(display, reallyStart);
			this.addChild(shuffle);
			shuffle.begin();
		}
		private function reallyStart():void
		{
			startScore();
			start();
			if (shuffle)
			{
				if(this.contains(shuffle))
				{
					shuffle.remove();
				}
			}
		}
		private function showNextBt():void
		{
			nextBt = new GenericBt(selecIA,"",138,70,display.main.data.getBMPById(13));
			nextBt.x = display.background.width * 0.5 - nextBt.width * 0.5;
			nextBt.y = display.background.height - nextBt.height * 2;
			nextBt.visible = false;
			container.addChild(nextBt);
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
				cards.x = 63 + (display.background.width * 1.156 * i) / p_number;
				cards.y = 111;
				var card	:Card = display.main.data.getCardById(players[i].cards[0]);
				cards.update(card.paramsNames,card.paramsValue,card.imgContainer, playable);
				cards.id = i;
				cards.close(true);
				container.addChild(cards);
				c_details.push(cards);
			}
			score.update(players,oldStack.length);
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
			TweenLite.delayedCall(1, openNextCard);
		}
		private function openNextCard():void
		{
			c_details[indexPlaying].close(false);
			c_details[indexPlaying].open();
			if (hasIA && indexPlaying == 1) 
			{
				if (nextBt!=null)nextBt.visible = true
			}
			else
			{
				if (nextBt!=null)nextBt.visible = false;
			}
		}
		private function startScore():void
		{
			score = new GameScore(this);
			container.addChild(score);
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
				for (var k:int = 0; k < c_details.length; k++) 
				{
					c_details[k].showProperFeedBack(0);
				}
				trace ("VALORES IGUAIS, NEXT PLS");
				oldStack = oldStack.concat(stack);
				stack.splice(0,stack.length);
				TweenLite.delayedCall(2.5,next);
			}
			else
			{
				trace ("player"+winningPlayerIndex,"é o vencedor!, ganha:", oldStack.length, stack.length);
				players[winningPlayerIndex].cards = players[winningPlayerIndex].cards.concat(oldStack,stack);
				c_details[winningPlayerIndex].removeBlink(false);
				for (var i2:int = 0; i2 < players.length; i2++) 
				{
					if (i2 == winningPlayerIndex)
					{
						c_details[i2].showProperFeedBack(1);
					}
					else
					{
						c_details[i2].showProperFeedBack(-1);
					}
				}
				TweenLite.delayedCall(2.5,next);
				stack.splice(0,stack.length);		
				oldStack.splice(0,oldStack.length);
				indexPlaying = winningPlayerIndex;
			}
			/*for (var j:int = 0; j < players.length; j++) 
			{
				trace("Player"+j,"tem",players[j].cards.length,"cartas.");
			}*/
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
			turns--;
			score.update(players, oldStack.length);
			trace ("TURN:", turns);
			if (turns<=0)
			{
				endGame=true;
			}
			else
			{
				for (var i:int = 0; i < players.length; i++) 
				{
					if (players[i].cards.length == 0)
						endGame = true;
				}
			}
			if (!endGame) 
			{
				showNewCard();
			}
			else
			{
				var winner:int = getActualWinner();
				display.goToWinner(hasIA,getWinLostOrDraw(),winner,players[winner].cards.length);
			}
		}
		
		private function getWinLostOrDraw():int
		{
			var returns	:int;
			if (players[0].cards.length > players[1].cards.length)
			{
				returns = 1;
			}
			else if (players[0].cards.length < players[1].cards.length)
			{
				if (hasIA)
				{
					returns = -1;
				}
				else
				{
					returns = 1;
				}
			}
			else if (players[0].cards.length == players[1].cards.length)
			{
				returns = 0;
			}
			return returns;
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
			while(container.numChildren>0)
			{
				container.removeChildAt(0);
			}
			if (shuffle)
			{
				if(this.contains(shuffle))
				{
					this.removeChild(shuffle);
				}
				shuffle = null;
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