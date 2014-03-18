package com
{
	import flash.display.Sprite;

	public final class Match extends Sprite
	{
		private var round		:int = 1;
		private var totalRounds	:int = 10;
		private var homeStarts	:Boolean;
		private var home		:Deck;
		private var away		:Deck;
		public  var narrator	:Narrator;
		public function Match()
		{
			narrator = new Narrator();
			this.addChild(narrator.asset);
		}
		public function setTeams(deck1:Deck, deck2:Deck = null):void
		{
			home = deck1;
			if (deck2 != null) away = deck2;
		}
		public function tossTheCoin():void
		{
			var homeWants	:int = Math.ceil(Math.random() * 2);
			var refereeSays	:int = Math.ceil(Math.random() * 2);
			homeStarts = homeWants == refereeSays;
			trace ("Time da casa começa:", homeStarts);
		}
		public function getAction(turn:int):void
		{
			switch(turn)
			{
				case 1:
					
					break;
			}
		}
	}
}