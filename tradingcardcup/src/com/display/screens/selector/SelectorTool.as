package com.display.screens.selector
{
	import com.data.Card;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class SelectorTool extends Sprite
	{
		public var screen			:SelectionScreen;
		public var container		:Sprite;
		public var containerMask	:Shape;
		public var right			:Sprite;
		public var left				:Sprite;
		public var pages			:int;
		public var cPage			:int = 1;
		public var columns			:int = 10;
		public var rows				:int = 1;
		public var distBtwnRows		:int = 60;
		public var distBtwnPgs		:int = 800;
		private var isTweening		:Boolean = false;
		public function SelectorTool(scn:SelectionScreen)
		{
			screen = scn;
			createMaskAndContainer();
		}
		public function createMaskAndContainer():void
		{
			container = new Sprite();
			containerMask = new Shape();
			container.x = 180;
			container.y = 450;
			this.addChild(container);
			container.mask = containerMask;
			containerMask.x = container.x;
			containerMask.y = container.y;
			containerMask.graphics.beginFill(0x000000,1);
			containerMask.graphics.drawRect(0,0,600,70);
			containerMask.visible = true;
			this.addChild(containerMask);
			container.mask = containerMask;
		}
		public function drawPointers():void
		{
			if (!right && !left)
			{
				right = new Sprite();
				left = new Sprite();
				right.x = 180 + containerMask.width + right.width + distBtwnRows;
				left.x = container.x  - left.width  - distBtwnRows;
				right.y = container.y;
				left.y 	= container.y;
				left.addEventListener(MouseEvent.CLICK, onClick);
				right.addEventListener(MouseEvent.CLICK, onClick);
				left.buttonMode = true;
				right.buttonMode = true;
				drawTriangle(left, true);
				drawTriangle(right);
				this.addChild(right);
				this.addChild(left);
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if (!isTweening)
			{
				var destination:Number;
				if(event.currentTarget == left) 
				{
					if (cPage > 1)
					{
						isTweening = true;
						destination = container.x+distBtwnPgs;
						TweenLite.to(container,1,{x:destination, onComplete:endTween});
						cPage--;
					}
				}
				else
				{
					if (cPage < pages)
					{
						isTweening = true;
						destination = container.x - distBtwnPgs
						TweenLite.to(container,1,{x:destination, onComplete:endTween});
						cPage++;
					}
				}
			}
		}
		public function endTween():void
		{
			isTweening = false;
		}
		public function drawTriangle(spr:Sprite, reverse:Boolean = false):void
		{
			var size	:Number = 50;
			var first	:Point = new Point(0, 0);
			var second	:Point = new Point(size, size);
			var third	:Point = new Point(0,  size);
			if (reverse)
			{
				first = new Point(0, 0);
				second= new Point(-size, size);
				third = new Point(0, size);
			}
			spr.graphics.lineTo		(first.x,first.y)
			spr.graphics.beginFill	(0x000000);
			spr.graphics.moveTo		(first.x,first.y);
			spr.graphics.lineTo		(second.x * 0.5, second.y*0.5);
			spr.graphics.lineTo		(third.x,third.y);
			spr.graphics.lineTo		(first.x,first.y);
		}
		public function clearContainer():void
		{
			while(container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
		public function fill(vector:Vector.<Card>):int
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
							var thumb:CardHolder = card.thumb;
							if (thumb == null)
							{
								thumb = new CardHolder();
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
									card.removeGlow(thumb);
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
		
		protected function onThumbClicked(event:MouseEvent):void
		{
			screen.thumbChosen(event.target.idtxt.text);
		}
	}
}