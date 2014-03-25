package com.display.screens.challenger
{
	import com.data.Card;
	import com.data.Deck;
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	import com.display.screens.selector.DeckDetails;
	
	import flash.events.MouseEvent;
	
	public class ChallengersScreen extends AbstractScreen
	{
		public var coritiba		:Vector.<int>;
		public var selectorTool	:ChallengerSelectorTool;
		public var cont			:GenericBt;
		public var selectedId	:int;
		public var selectedDeck	:DeckDetails;
		
		public function ChallengersScreen(disp:MainDisplay)
		{
			super(disp);
			fillEnemies();
			selectorTool = new ChallengerSelectorTool(this,10,2,60,800,600,150);
			fillTeams();
			this.addChild(selectorTool);
			
			selectedDeck = new DeckDetails();
			selectedDeck.x = display.background.width * 0.5 - selectedDeck.width * 0.5;
			this.addChild(selectedDeck);
			
			cont = new GenericBt();
			cont.x = display.background.width * 0.5;
			cont.y = display.background.height - cont.height * 3;
			cont.alpha = 0.2;
			cont.mouseChildren = false;
			this.addChild(cont);
		}
		public function thumbChosen(id:int):void
		{
			selectedId = id;
			selectedDeck.fillDeckDetails(display.main.data.teams.getTeamDeckById(id).inUse);
			selectedDeck.updateDeckAssetNames();
			cont.alpha = 1;
			cont.buttonMode = true;
			cont.addEventListener(MouseEvent.CLICK, onClickContinue);
		}
		private function fillEnemies():void
		{
			coritiba = new Vector.<int>();
			coritiba.push(2,3,11,23,30);
		}
		private function getDeck(vec:Vector.<Card>):Deck
		{
			var deck:Deck = new Deck();
			deck.inUse = vec;
			return deck;
		}
		private function fillTeams():void
		{
			selectorTool.fillDeck(display.main.data.teams.fullteams);
		}
		protected function onClickContinue(event:MouseEvent):void
		{
			display.goToMatch();
		}
	}
}