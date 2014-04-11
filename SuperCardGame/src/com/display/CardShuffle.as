package com.display
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class CardShuffle extends Sprite
	{
		private var m_main	:Display;
		private var vec	:Vector.<Sprite>;
		
		private var cont		:int = 0;
		private var numOfCards	:int = 6;
		private var timeToTween	:Number = 0.5;
		private var amComplete	:Function;
		
		public function CardShuffle(main:Display, onComplete:Function)
		{
			super();
			amComplete=onComplete;
			m_main = main;
		}
		public function begin():void
		{
			vec = fillVec(vec);
			tweenDown(0);
		}
		public function tweenDown(index:int):void
		{
			TweenLite.to(vec[index],timeToTween,{y:m_main.background.height*0.5-vec[index].height*0.38, ease:Back.easeOut, onComplete:tweenNext})
		}
		private function tweenNext():void
		{
			cont++;
			if (cont<vec.length)
			{
				tweenDown(cont);
			}
			else
			{
				cont--;
				tweenSideWays(cont);
			}
		}
		private function tweenLast(mc:DisplayObject):void
		{
			if (cont!=vec.length)this.setChildIndex(mc,0);
			cont--;
			if (cont>=0)
				tweenSideWays(cont);
			else
			{
				TweenLite.delayedCall(0.4,amComplete);
			}
		}
		private function tweenSideWays(index:int):void
		{
			var posX:int;
			var posY:int = m_main.background.height*0.5-vec[index].height*0.5;
			index % 2 != 0 ? posX = 63 : posX = m_main.background.width - 63 - vec[index].width ;
			trace ("POSX",posX, vec[index].width, posY);
			TweenLite.to(vec[index],timeToTween,{x:posX,y:posY, ease:Back.easeInOut,onComplete:tweenLast,onCompleteParams:[vec[index]]});
		}
		private function fillVec(vec:Vector.<Sprite>):Vector.<Sprite>
		{
			vec = new Vector.<Sprite>();
			for (var i:int = 0; i < numOfCards; i++) 
			{
				var spr:Sprite = new Sprite();
				var bmp:Bitmap = new Bitmap();
				bmp.bitmapData = m_main.main.data.getBMPById(3);
				spr.addChild(bmp);
				spr.y = -spr.height;
				spr.x = m_main.background.width * 0.5 - spr.width * 0.5;
				vec.push(spr);
				addChild(spr);
			}
			return vec;
		}
		public function destroy():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			vec = null;
		}
		
		public function remove():void
		{
			TweenLite.to(this,timeToTween,{alpha:0, onComplete:destroy});
		}
	}
}