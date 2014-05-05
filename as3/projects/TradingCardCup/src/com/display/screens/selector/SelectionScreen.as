package com.display.screens.selector
{
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	
	import flash.events.MouseEvent;
	
	public class SelectionScreen extends AbstractScreen
	{
		public var selector		:CardSelectorTool;
		public var deckDetails	:DeckDetails;
		public var btCont		:GenericBt;
		public function SelectionScreen(disp:MainDisplay)
		{
			super(disp);
			
			btCont = new GenericBt();
			btCont.x = display.background.width * 0.5;
			btCont.y = display.background.height - btCont.height * 3;
			btCont.alpha = 0.2;
			btCont.mouseChildren=false;
			this.addChild(btCont);
			
			selector = new CardSelectorTool(this,10,1,60,800,600,70);
			this.addChild(selector);
			
			deckDetails = new DeckDetails();
			deckDetails.x = display.background.width * 0.5 - deckDetails.width * 0.5;
			this.addChild(deckDetails);
		}
		
		protected function teamSelected(event:MouseEvent):void
		{
			display.main.data.teams.setPlayerTeam(deckDetails.cards);
			display.goToChallenger();
		}
		
		public function thumbChosen(id:int):void
		{
			deckDetails.setCard(display.main.data.album.getCardById(id));
			if (deckDetails.cards.length == 5)
			{
				btCont.alpha = 1;
				btCont.buttonMode = true;
				btCont.addEventListener(MouseEvent.CLICK, teamSelected);
			}
			else
			{
				btCont.alpha = 0.2;
				btCont.buttonMode = false;
				btCont.removeEventListener(MouseEvent.CLICK, teamSelected);				
			}
		}
	}
}