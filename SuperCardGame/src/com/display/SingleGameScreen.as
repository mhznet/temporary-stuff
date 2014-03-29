package com.display
{
	import com.data.Card;
	import com.display.Screens.AbstractScreen;
	
	public class SingleGameScreen extends AbstractScreen
	{
		private var playerChooses	:Boolean;
		private var turns			:int = 21;
		private var player			:Vector.<int>;
		private var ia				:Vector.<int>;
		public function SingleGameScreen(disp:Display)
		{
			super(disp);
			getDecks();
			showCards();
		}
		private function showCards():void
		{
			var p1:Card = display.main.data.getCardById(player[0]);
			var p2:Card = display.main.data.getCardById(ia[0]);
			if (!p1 || !p2) throw new Error("Cade a carta?");
			p1.x = display.background.width * 0.3 - p1.width * 0.5;
			p2.x = display.background.width * 0.6 - p1.width * 0.5;
			this.addChild(p1);
			this.addChild(p2);
		}
		private function getDecks():void
		{
			var vec:Vector.<Vector.<int>> = display.main.data.splitDeck(2);
			player = vec[0];
			ia = vec[1];
		}
	}
}