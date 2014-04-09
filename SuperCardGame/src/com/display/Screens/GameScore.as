package com.display.Screens
{
	import com.data.Player;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GameScore extends Sprite
	{
		private var m_bg	:Sprite;
		private var textNum	:int;
		private var txtVec	:Vector.<TextField>;
		
		public function GameScore(p_num:int)
		{
			textNum = p_num;
			super();
			create();
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
				text.x = 550 * i;
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