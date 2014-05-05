package com.display.cards
{
	import com.data.Card;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class SelectorTool extends Sprite
	{
		protected var container		:Sprite;
		protected var containerMask	:Shape;
		protected var right			:Sprite;
		protected var left			:Sprite;
		protected var pages			:int;
		protected var cPage			:int = 1;
		protected var columns		:int;
		protected var rows			:int;
		protected var distBtwnRows	:int;
		protected var distBtwnPgs	:int;
		protected var contWidth		:int;
		protected var contHeight	:int;
		protected var isTweening	:Boolean = false;
		
		public function SelectorTool(columnsNumber:int, rowsNumber:int, distBetweenRows:int, distBetweenPages:int, containerWidth:Number, containerHeight:Number)
		{
			columns = columnsNumber;
			rows = rowsNumber;
			distBtwnPgs = distBetweenPages;
			distBtwnRows = distBetweenRows;
			contWidth = containerWidth;
			contHeight = containerHeight;
			createMaskAndContainer();
		}
		protected function createMaskAndContainer():void
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
			containerMask.graphics.drawRect(0,0,contWidth,contHeight);
			containerMask.visible = true;
			this.addChild(containerMask);
			container.mask = containerMask;
		}
		protected function drawPointers():void
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
		protected function endTween():void
		{
			isTweening = false;
		}
		protected function drawTriangle(spr:Sprite, reverse:Boolean = false):void
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
		protected function onThumbClicked(event:MouseEvent):void
		{
		}
		protected function clearContainer():void
		{
			while(container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
		public function fill(vector:Vector.<Card>):int
		{
			drawPointers();
			return 0;
		}
	}
}