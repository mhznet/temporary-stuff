package com.display.screens.selector
{
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	
	import flash.events.MouseEvent;
	
	public class SelectionScreen extends AbstractScreen
	{
		public var selector	:SelectorTool;
		public var deck		:Deck;
		public var btCont	:GenericBt;
		public function SelectionScreen(disp:MainDisplay)
		{
			super(disp);
			
			btCont = new GenericBt();
			btCont.x = display.background.width * 0.5;
			btCont.y = display.background.height - btCont.height * 3;
			btCont.alpha = 0.2;
			btCont.mouseChildren=false;
			this.addChild(btCont);
			
			selector = new SelectorTool(this);
			this.addChild(selector);
			
			deck = new Deck();
			deck.x = display.background.width * 0.5 - deck.width * 0.5;
			this.addChild(deck);
		}
		
		protected function teamSelected(event:MouseEvent):void
		{
			display.goToChallenger();
		}
		
		public function thumbChosen(id:int):void
		{
			deck.setCard(display.main.data.album.getCardById(id));
			if (deck.inUse.length == 5)
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