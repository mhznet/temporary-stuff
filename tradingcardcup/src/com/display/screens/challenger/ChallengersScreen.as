package com.display.screens.challenger
{
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	import com.display.screens.selector.Deck;
	
	import flash.events.MouseEvent;
	
	public class ChallengersScreen extends AbstractScreen
	{
		public var selectorTool	:ChallengerSelectorTool;
		public var cont			:GenericBt;
		
		public function ChallengersScreen(disp:MainDisplay)
		{
			super(disp);
			selectorTool = new ChallengerSelectorTool(this,5,2,60,800,600,150);
			fillTeams();
			this.addChild(selectorTool);
			
			cont = new GenericBt();
			cont.x = display.background.width * 0.5;
			cont.y = display.background.height - cont.height * 3;
			cont.alpha = 0.2;
			cont.mouseChildren = false;
			//cont.buttonMode = true;
			//cont.addEventListener(MouseEvent.CLICK, onClickContinue);
			this.addChild(cont);
		}
		private function fillTeams():void
		{
			var enemiesDeck:Vector.<Deck> = new Vector.<Deck>();
			for (var i:int = 0; i < 6; i++)
			{
				var deck:Deck = new Deck();
				deck.inUse = display.main.data.album.getRandomDeck(5);
				enemiesDeck.push(deck);
			}
			selectorTool.fillDeck(enemiesDeck);
		}
		protected function onClickContinue(event:MouseEvent):void
		{
			display.goToMatch();
		}
	}
}