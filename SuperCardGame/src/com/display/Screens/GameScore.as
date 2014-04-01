package com.display.Screens
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class GameScore extends Sprite
	{
		private var m_bg	:Sprite;
		private var p1_txt	:TextField;
		private var p2_txt	:TextField;
		public function GameScore()
		{
			super();
			create();
		}
		
		private function create():void
		{
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			p1_txt = new TextField();
			p2_txt = new TextField();
			p1_txt.width = p2_txt.width = 100;
			p1_txt.height = p2_txt.height = 50;
			p2_txt.x += p2_txt.width*0.5;
			p1_txt.x -= p1_txt.width*0.5;
			m_bg.graphics.drawRect(p1_txt.x,0,200,50);
			this.addChild(p1_txt);
			this.addChild(p2_txt);
			update();
		}
		
		public function update(p1:String = "TBA", p2:String = "TBA"):void
		{
			p1_txt.text = p1;
			p2_txt.text = p1;
		}
	}
}