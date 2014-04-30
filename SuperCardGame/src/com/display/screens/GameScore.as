package com.display.screens
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
		
		private var pilhaNum:int;
		private var pilhaBt	:Sprite;
		private var pilhaTxt:TextField;
		
		
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
			turnTx.embedFonts = true;
			turnTx.width = turnBt2.width-20;
			turnTx.height = turnBt2.height;
			turnTx.selectable = false;
			turnTx.border = false;
			turnTx.borderColor = 0xFFFFFF;
			turnTx.textColor = 0xFFFFFF;
			turnTx.multiline = true;
			turnTx.wordWrap = true;
			//updateTurn();
			showTurn();
			turnBt2.addChild(turnTx);
		}
		
		private function tweens():void
		{
			TweenLite.to(turnBt2,1,{x:m_main.display.background.width * 0.5 + 10, ease:Back.easeOut});
			for (var i:int = 0; i < textNum; i++) 
			{
				TweenLite.to(txtVec[i],2,{delay:1,alpha:1});
			}
		}
		
		public function updateTurn():void
		{
			TweenLite.to(turnBt2,0.5,{x:m_main.display.background.width * 0.5 + 10 + turnBt2.width, ease:Back.easeOut, onComplete:showTurn});
			if (pilhaBt.x!=m_main.display.background.width * 0.5 + 10 + pilhaBt.width)
			{
				TweenLite.to(pilhaBt,0.5,{x:m_main.display.background.width * 0.5 + 10 + pilhaBt.width, ease:Back.easeOut});
			}
		}
		public function updateAndShowPilha():void
		{
			if (pilhaNum > 0)
			{
				pilhaTxt.text = "CARTAS NA PILHA: " + pilhaNum;
				pilhaTxt.setTextFormat(getTextFormat(true));
				TweenLite.to(pilhaBt,0.5,{delay:0.5,x:m_main.display.background.width * 0.5 + 10, ease:Back.easeOut});
			}
		}
		private function showTurn():void
		{
			updateAndShowPilha();
			turnTx.text = "TURNOS PARA ACABAR: " + m_main.turns;
			turnTx.setTextFormat(getTextFormat(true));
			TweenLite.to(turnBt2,1,{x:m_main.display.background.width * 0.5 + 10, ease:Back.easeOut});
		}
		
		private function create():void
		{
			createPilha();
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			m_bg.visible = false;
			txtVec = new Vector.<TextField>();
			for (var i:int = 0; i < textNum; i++) 
			{
				var text:TextField = new TextField();
				text.embedFonts = true;
				text.selectable = false;
				text.width 	= 200;
				//text.height = 150;
				text.text 	= "TBA";
				text.x = 100 + (550  * i);
				text.alpha = 0;
				text.y = m_main.display.background.height * 0.82;
				this.addChild(text);
				txtVec.push(text);
			}
			m_bg.graphics.drawRect(txtVec[0].x,0,txtVec[txtVec.length-1].x+txtVec[txtVec.length-1].width,50);
		}
		
		private function createPilha():void
		{
			pilhaBt = new Sprite();
			var bt2bmp:Bitmap = new Bitmap();
			bt2bmp.bitmapData = m_main.display.main.data.getBMPById(10);
			bt2bmp.scaleX *= -1;
			bt2bmp.x = bt2bmp.width;
			pilhaBt.addChild(bt2bmp);
			pilhaBt.x = m_main.display.background.width * 0.5 + 10 + pilhaBt.width;
			pilhaBt.y = m_main.display.background.height * 0.43;
			this.addChild(pilhaBt);
			
			pilhaTxt = new TextField();
			pilhaTxt.embedFonts = true;
			pilhaTxt.width = pilhaBt.width-20;
			pilhaTxt.height = pilhaBt.height;
			pilhaTxt.selectable = false;
			pilhaTxt.border = false;
			pilhaTxt.borderColor = 0xFFFFFF;
			pilhaTxt.textColor = 0xFFFFFF;
			pilhaTxt.multiline = true;
			pilhaTxt.wordWrap = true;
			pilhaBt.addChild(pilhaTxt);
		}
		
		private function getTextFormat(turn:Boolean = false):TextFormat
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = m_main.display.BEBAS;
			if (!turn)
			{
				textFormat.size = 53;
				textFormat.align = TextFormatAlign.CENTER;
			}
			else
			{
				textFormat.size = 25;
				textFormat.align = TextFormatAlign.RIGHT;
			}
			textFormat.bold = false;
			textFormat.kerning = true;
			textFormat.color = 0xFFFFFF;
			return textFormat;
		}
		
		public function update(vec:Vector.<Player>, oldStack:int):void
		{
			pilhaNum = oldStack;
			updateTurn();
			updateCards(vec);
		}
		
		private function updateCards(vec:Vector.<Player>):void
		{
			for (var i:int = 0; i < txtVec.length; i++) 
			{
				TweenLite.to(txtVec[i],0.5,{alpha:0, onComplete:showCard, onCompleteParams:[i,vec[i].cards.length]});
			}
		}
		private function showCard(index:int,length:int):void
		{
			if (txtVec)
			{
				txtVec[index].text = String(length) + " CARTAS";
				txtVec[index].setTextFormat(getTextFormat());
				TweenLite.to(txtVec[index],1,{alpha:1});
			}
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