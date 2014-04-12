package com.display.Screens
{
	import com.data.Player;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GameScore extends Sprite
	{
		private var m_main	:SingleGameScreen;
		private var m_bg	:Sprite;
		private var textNum	:int;
		private var txtVec	:Vector.<TextField>;
		private var turnTx	:TextField;
		private var turnBt1	:Sprite;
		private var turnBt2	:Sprite;
		
		public function GameScore(main:SingleGameScreen)
		{
			textNum = main.p_number;
			m_main = main;
			super();
			create();
			turns();
			tweens();
		}
		
		private function turns():void
		{
			/*turnBt1 = new Sprite();
			var bt1bmp:Bitmap = new Bitmap();
			bt1bmp.bitmapData = m_main.display.main.data.getBMPById(10);
			turnBt1.addChild(bt1bmp);
			turnBt1.x = m_main.display.background.width * 0.5 - turnBt1.width - 10;
			turnBt1.y = m_main.display.background.height * 0.4;
			this.addChild(turnBt1);*/
			
			turnBt2 = new Sprite();
			var bt2bmp:Bitmap = new Bitmap();
			//bt2bmp.bitmapData = m_main.display.main.data.getBMPById(12);
			bt2bmp.bitmapData = m_main.display.main.data.getBMPById(10);
			bt2bmp.scaleX *= -1;
			bt2bmp.x = bt2bmp.width;
			turnBt2.addChild(bt2bmp);
			turnBt2.x = m_main.display.background.width * 0.5 + 10 + turnBt2.width;
			turnBt2.y = m_main.display.background.height * 0.3;
			this.addChild(turnBt2);
			
			turnTx = new TextField();
			turnTx.width = turnBt2.width;
			turnTx.height = turnBt2.height;
			turnTx.selectable = false;
			turnTx.text = "RESTAM: " + m_main.turns + " TURNOS!";
			turnTx.border = false;
			turnTx.borderColor = 0xFFFFFF;
			turnTx.textColor = 0xFFFFFF;
			turnBt2.addChild(turnTx);
			trace ("add",turnTx);
		}
		
		private function tweens():void
		{
			TweenLite.to(turnBt2,1,{x:m_main.display.background.width * 0.5 + 10, ease:Back.easeOut});
			for (var i:int = 0; i < textNum; i++) 
			{
				TweenLite.to(txtVec[i],2,{delay:1,alpha:1});
			}
		}
		
		private function create():void
		{
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			m_bg.visible = false;
			txtVec = new Vector.<TextField>();
			for (var i:int = 0; i < textNum; i++) 
			{
				var text:TextField = new TextField();
				text.selectable = false;
				text.width 	= 200;
				text.height = 150;
				text.text 	= "TBA";
				text.x = 100 + (550  * i);
				text.alpha = 0;
				text.y = m_main.display.background.height * 0.85;
				this.addChild(text);
				txtVec.push(text);
			}
			m_bg.graphics.drawRect(txtVec[0].x,0,txtVec[txtVec.length-1].x+txtVec[txtVec.length-1].width,50);
		}
		
		private function getTextFormat():TextFormat
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 30;
			textFormat.bold = true;
			textFormat.color = 0xFFFFFF;
			textFormat.align = TextFormatAlign.CENTER;
			return textFormat;
		}
		
		public function update(vec:Vector.<Player>):void
		{
			for (var i:int = 0; i < txtVec.length; i++) 
			{
				txtVec[i].text = String(vec[i].cards.length) + " CARTAS";
				txtVec[i].setTextFormat(getTextFormat());
			}
			turnTx.text = m_main.turns + " TURNOS!";
		}
		
		public function destroy():void
		{
			m_bg = null;
			txtVec	= null;
			textNum	= 0;
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
	}
}