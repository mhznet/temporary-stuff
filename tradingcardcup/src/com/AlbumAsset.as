package com
{
	import flash.display.Sprite;
	
	public class AlbumAsset extends Sprite
	{
		public var pages			:int;
		public var columns			:int = 7;
		public var rows				:int = 5;
		public var distBtwnRows		:int = 60;
		public var distBtwnPgs		:int = 2;
		public function AlbumAsset()
		{
			super();
		}
		
		public function clear():void
		{
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		public function fill(vector:Vector.<Card>):int
		{
			clear();
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
							var thumb:CardHolder = card.thumb;
							if (thumb == null)
							{
								thumb = new CardHolder();
								thumb.y = (distBtwnRows * row);
								thumb.x = 3 + (distBtwnRows * column) + (page * distBtwnPgs);
								thumb.idtxt.text = card.id.toString();
								thumb.nametxt.text = card.m_name;
								thumb.tenhotxt.text = card.equipped.toString();
								thumb.equippedtxt.text = card.equipped.toString();
								thumb.buttonMode = true;
								thumb.mouseChildren = false;
								card.thumb = thumb;
								card.addChild(thumb);
							}
							cont[page][row][column] = card;
							this.addChild(card);
							if (i+1 >= vector.length)
							{
								return pages;
							}
							i++;
						}
					}
				}
			}
			return pages;
		}
	}
}