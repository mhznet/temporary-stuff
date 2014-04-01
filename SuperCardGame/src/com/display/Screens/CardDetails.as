package com.display.Screens
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class CardDetails extends Sprite
	{
		public var active			:Boolean = false;
		public var m_main			:SingleGameScreen;
		public var p_num			:int;
		public var m_bg				:Sprite;
		public var m_back			:Sprite;
		public var m_cont			:Sprite;
		public var m_value			:Vector.<TextField>;
		public var m_name			:Vector.<TextField>;
		public var m_hit			:Vector.<Sprite>;
		public var m_upperhit		:Vector.<Sprite>;
		public function CardDetails(paramsNum:int, main:SingleGameScreen)
		{
			super();
			m_main = main;
			p_num = paramsNum;
			start();
		}
		public function update(t_name:Vector.<String> = null, t_value:Vector.<String> = null, spr:Sprite = null):void
		{
			if (spr!=null)
			{
				while(m_cont.numChildren > 0)
				{
					m_cont.removeChild(m_cont.getChildAt(0));
				}
				m_cont.addChild(spr);
			}
			for (var i:int = 0; i < m_value.length; i++) 
			{
				var val:String;
				var nam:String;
				t_name==null ? nam = "NAME_" + i : nam = t_name[i]; 
				t_value==null? val = "VALUE_" + i : val = t_value[i]; 
				m_value[i].text = val;
				m_name[i].text = nam;
			}
		}
		private function start():void
		{
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			m_cont = new Sprite();
			m_cont.y = 0;
			this.addChild(m_cont);
			m_name = new Vector.<TextField>();
			m_value = new Vector.<TextField>();
			m_hit = new Vector.<Sprite>();
			m_upperhit = new Vector.<Sprite>();
			for (var i:int = 0; i < p_num; i++)
			{
				var m_y:	int = 30;
				var t_hit	:Sprite = new Sprite();
				var t_uhit	:Sprite = new Sprite();
				var t_name	:TextField = new TextField();
				var t_value	:TextField = new TextField();
				t_value.width = t_name.width = 100;
				t_value.height = t_name.height = 24;
				t_name.x = 10;
				t_value.x = t_name.x + t_value.width;
				t_name.y += m_y * i + 120;
				t_value.y = t_name.y;
				t_hit.graphics.beginFill(0xFF794B);
				t_hit.graphics.drawRect(10,m_y*i + 120,200,25);
				t_uhit.graphics.beginFill(0xFF794B,0);
				t_uhit.graphics.drawRect(10,m_y*i + 120,200,25);
				t_uhit.name = i.toString();
				m_name.push(t_name);
				m_value.push(t_value);
				m_hit.push(t_hit);
				m_upperhit.push(t_uhit);
				this.addChild(t_hit);
				this.addChild(t_name);
				this.addChild(t_value);
				this.addChild(t_uhit);
			}
			m_bg.graphics.drawRect(0,0,220,50*m_value.length);
			m_cont.x = m_bg.width*0.35;
		}
		public function open(close:Boolean = false, events:Boolean = false):void
		{
			for (var i:int = 0; i < m_upperhit.length; i++) 
			{
				removeGlow(i);
				if (close)
				{
					active = false;
					if (m_back == null)
						m_back = m_main.display.main.data.cover;
						this.addChild(m_back);
					m_upperhit[i].buttonMode = false;
					m_upperhit[i].removeEventListener(MouseEvent.CLICK,onTxtSelected);;
				}
				else
				{
					active = true;
					if (m_back)
					{
						if (this.contains(m_back))
						{
							this.removeChild(m_back);
							m_main.display.main.data.cover = m_back;						
						}
					}
					if (events)
					{
						m_upperhit[i].buttonMode = true;
						m_upperhit[i].addEventListener(MouseEvent.CLICK,onTxtSelected);
					}
					else
					{
						m_upperhit[i].buttonMode = false;
						m_upperhit[i].removeEventListener(MouseEvent.CLICK,onTxtSelected);;
					}
				}
			}
		}
		protected function onTxtSelected(event:MouseEvent):void
		{
			var value:int = int(event.currentTarget.name);
			addGlow(value);
			m_main.compareParams(value);
		}
		public function cleanGlows():void
		{
			for (var i:int = 0; i < m_hit.length; i++) 
			{
				removeGlow(i);
			}
		}
		public function addGlow(index:int):void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			m_hit[index].filters = [glow];
		}
		public function removeGlow(index:int):void
		{
			var glow:GlowFilter = new GlowFilter();
			m_hit[index].filters = [glow];
		}
		
	}
}