package com.display.utils
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class InitialLoading extends Sprite
	{
		private var load	:MovieClip;
		private var text	:String = "CARREGANDO"
		private var vec		:Vector.<Sprite>;
			
		public function InitialLoading()
		{
			super();
			//addLoading();
			makeCards();
			//beginTween(0,vec[0]);
			beginTween2(0);
		}
		
		private function beginTween2(index:int):void
		{
			if (index>=1)TweenLite.to(vec[index-1], 0.5,{y:0});
			if (index < vec.length)
			{
				this.setChildIndex(vec[index], this.numChildren-1);
				TweenLite.to(vec[index], 1,{y:vec[index].y-20, onComplete:beginTween2, onCompleteParams:[index+1], ease:Back.easeOut});
			}
			else
			{
				beginTween2(0);
			}
		}
		
		private function beginTween(index:int, spr:Sprite):void
		{
			if (index < vec.length)
				this.setChildIndex(spr, 0);
				TweenLite.to(vec[index], 3,{y:150, onComplete:continueTween, onCompleteParams:[index, vec[index]], ease:Back.easeOut});
		}
		private function continueTween(index:int, spr:Sprite):void
		{
			if (index < vec.length)
				TweenLite.to(vec[index], 3,{y:600, onComplete:beginTween, onCompleteParams:[index+1, vec[index]], ease:Back.easeOut});
		}
		
		private function makeCards():void
		{
			vec = new Vector.<Sprite>();
			for (var i:int = 0; i < text.length; i++) 
			{
				var card	:Sprite = new Sprite();
				var shape	:Shape	= new Shape();
				var shp 	:Shape = new Shape();
				//var shap	:Shape = new Shape();
				var sizeX	:int = 30;
				var sizeY	:int = 60;
				
				shape.graphics.beginFill(0x009900);
				shape.graphics.drawRect(0,0,sizeX,sizeY);
				shape.graphics.endFill();
				card.addChild(shape);
				
				shp.graphics.beginFill(0XFFFFFF);
				shp.graphics.drawRect(3,3,sizeX-5,sizeY-5);
				shp.graphics.endFill();
				card.addChild(shp);
				
				/*shap.graphics.beginFill(0x6699FF);
				shap.graphics.drawRect(20,20,sizeX-40,sizeY-40);
				shap.graphics.endFill();
				card.addChild(shap);*/
				
				var txt		:TextField = new TextField();
				var form	:TextFormat = new TextFormat();
				form.bold = false;
				form.color = 0x000000;
				form.align = TextFormatAlign.CENTER;
				form.size = 30;
				//txt.width = 220;
				//txt.height = 335;
				txt.y = shp.height * 0.15;
				txt.x = -shp.width * 1.4 /*+ txt.width*0.5*/;
				txt.selectable = false;
				txt.background = false;
				txt.backgroundColor = 0x0000FF;
				txt.text = text.charAt(i);
				txt.setTextFormat(form);
				card.addChild(txt);
				
				vec.push(card);
				/*card.x = 250;
				card.y = -350;*/
			}
			for (var j:int = vec.length-1; j >= 0; j--) 
			{
				vec[j].y = 0;
				vec[j].x = 32 * j;
				this.addChild(vec[j]);
			}
			
		}
		private function addLoading():void
		{
			load = new MovieClip();
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF794B);
			shape.graphics.drawCircle(50, 50, 30);
			shape.graphics.endFill();
			load.addChild(shape);
			addChild(load);
		}
	}
}