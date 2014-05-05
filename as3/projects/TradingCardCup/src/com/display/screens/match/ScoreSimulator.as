package com.display.screens.match
{
	import com.data.Card;
	import com.data.Deck;

	public class ScoreSimulator
	{
		public var homeScore	:int;
		public var awayScore	:int;
		private var p2			:Vector.<Card>;
		private var p1			:Vector.<Card>;
		private var d2			:Deck;
		private var d1			:Deck;
		
		public function ScoreSimulator(ia:Vector.<Card>, player:Vector.<Card>)
		{
			//if (!ia.length < 6 || !player.length <6) trace ("ERRO no tamanho dos times!");
			p2 = ia;
			p1 = player;
			d2 = new Deck();
			d2.inUse = p2;
			d1 = new Deck();
			d1.inUse = p1;
			sortFinalScore();
		}
		
		private function sortFinalScore():void
		{
			
		}
		
		public function getSide():String
		{
			return "";
		}
		public function getGoalSpeech():String
		{
			var golToReturn	:String;
			const gol		:String = "Gol!";
			const goool		:String = "Gooooooooooooool!";
			const golaco	:String = "Golaço!!!";
			var random		:int = Math.ceil(Math.random() * 5);
			if (random == 5)
			{
				golToReturn = golaco;
			}
			else if (gol < 3)
			{
				golToReturn = goool;
			}
			else
			{
				golToReturn = gol;
			}
			return golToReturn;
		}
	}
}