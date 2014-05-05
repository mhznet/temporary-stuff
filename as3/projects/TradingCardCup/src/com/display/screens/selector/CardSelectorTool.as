package com.display.screens.selector
{
	import com.data.Card;
	import com.display.cards.Thumb;
	import com.display.cards.SelectorTool;
	
	import flash.events.MouseEvent;
	
	public class CardSelectorTool extends SelectorTool
	{
		public var screen			:SelectionScreen;
		public function CardSelectorTool(scn:SelectionScreen, columnsNumber:int, rowsNumber:int, distBetweenRows:int, distBetweenPages:int, containerWidth:Number,containerHeight:Number)
		{
			super(columnsNumber, rowsNumber, distBetweenRows, distBetweenPages, containerWidth, containerHeight)
			screen = scn;
		}
		override public function fill(vector:Vector.<Card>):int
		{
			clearContainer();
			if (vector.length > 0)
			{
				pages = Math.ceil(vector.length/(rows*columns));
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
							var card:Card = vector[i];
							var thumb:Thumb = card.thumb;
							if (thumb == null)
							{
								thumb = new Thumb(card.url);
								thumb.y = (distBtwnRows * row);
								thumb.x = 3 + (distBtwnRows * column) + (page * distBtwnPgs);
								thumb.idtxt.text = card.id.toString();
								thumb.nametxt.text = card.m_name;
								thumb.tenhotxt.text = card.doHave.toString();
								if(card.doHave)
								{
									thumb.alpha = 1;
									thumb.buttonMode = true;
									thumb.addEventListener(MouseEvent.CLICK, onThumbClicked);
									thumb.equippedtxt.text = card.getEquipped().toString();
									thumb.removeGlow();
								}
								else
								{
									thumb.alpha = 0.2;
									thumb.equippedtxt.text = "";
								}
								thumb.mouseChildren = false;
								card.thumb = thumb;
								card.addChild(thumb);
							}
							cont[page][row][column] = card;
							container.addChild(card);
							if (i+1 >= vector.length)
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
			screen.thumbChosen(event.target.idtxt.text);
		}
	}
}