package com.display.screens.challenger
{
	import com.data.Deck;
	import com.display.cards.SelectorTool;
	import com.display.cards.Thumb;
	
	import flash.events.MouseEvent;
	
	public class ChallengerSelectorTool extends SelectorTool
	{
		private var activeThumb:Thumb;
		private var screen:ChallengersScreen;
		public function ChallengerSelectorTool(scn:ChallengersScreen,columnsNumber:int, rowsNumber:int, distBetweenRows:int, distBetweenPages:int, containerWidth:Number, containerHeight:Number)
		{
			super(columnsNumber, rowsNumber, distBetweenRows, distBetweenPages, containerWidth, containerHeight);
			screen = scn;
		}
		
		public function fillDeck(array:Vector.<Deck>):int
		{
			clearContainer();
			if (array.length > 0)
			{
				pages = Math.ceil(array.length/(rows*columns));
				var cont	:Array = new Array();
				var i		:int = 0;
				for (var page:int = 0; page < pages; page++) 
				{
					cont[page] = new Array();
					for (var row:int = 0; row < rows; row++) 
					{
						cont[page][row] = new Array();
						for (var column:int = 0; column < columns; column++) 
						{
							var deck:Deck = array[i];
							var thumb:Thumb = deck.thumb;
							if (thumb == null)
							{
								thumb = new Thumb();
								thumb.y = (distBtwnRows * row);
								thumb.x = 3 + (distBtwnRows * column) + (page * distBtwnPgs);
								thumb.addEventListener(MouseEvent.CLICK, onThumbClicked);
								thumb.buttonMode = true;
								thumb.nametxt.text = deck.m_name;
								thumb.idtxt.text = deck.id.toString();
								thumb.removeGlow();
								//thumb.tenhotxt.text = card.doHave.toString();
								/*if(card.doHave)
								{
									thumb.alpha = 1;
									thumb.equippedtxt.text = card.getEquipped().toString();
									
								}
								else
								{
									thumb.alpha = 0.2;
									thumb.equippedtxt.text = "";
								}*/
								thumb.mouseChildren = false;
								deck.thumb = thumb;
								deck.addChild(thumb);
							}
							cont[page][row][column] = deck;
							container.addChild(deck);
							if (i+1 >= array.length)
							{
								drawPointers();
								return pages;
							}
							i++;
						}
					}
				}
			}
			return pages;
		}
		override protected function onThumbClicked(event:MouseEvent):void
		{
			if (activeThumb!=null) activeThumb.removeGlow();
			activeThumb = Thumb(event.target);
			activeThumb.addGlow();
			screen.thumbChosen(event.target.idtxt.text);
		}
	}
}