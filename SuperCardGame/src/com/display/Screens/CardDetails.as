package com.display.Screens
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class CardDetails extends Sprite
	{
		public var id				:int;
		public var playAble			:Boolean;
		public var m_main			:SingleGameScreen;
		public var p_num			:int;
		public var m_bg				:Sprite;
		public var m_back			:Sprite;
		public var m_cont			:Sprite;
		public var m_value			:Vector.<TextField>;
		public var m_name			:Vector.<TextField>;
		public var m_hit			:Vector.<Sprite>;
		public var m_upperhit		:Vector.<Sprite>;
		private var counter			:int=0;
		public function CardDetails(paramsNum:int, main:SingleGameScreen)
		{
			super();
			m_main = main;
			p_num = paramsNum;
			start();
		}
		public function update(t_name:Vector.<String> = null, t_value:Vector.<String> = null, spr:Sprite = null, isPlayable:Boolean = false):void
		{
			playAble = isPlayable;
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
				m_value[i].text = val.toUpperCase();
				m_name[i].text = nam.toUpperCase();
				m_value[i].setTextFormat(getTextFormat(false));
				m_name[i].setTextFormat(getTextFormat(true));
			}
		}
		private function start():void
		{
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			m_cont = new Sprite();
			m_cont.y = 14;
			m_cont.x = 14;
			this.addChild(m_cont);
			m_name = new Vector.<TextField>();
			m_value = new Vector.<TextField>();
			m_hit = new Vector.<Sprite>();
			m_upperhit = new Vector.<Sprite>();
			for (var i:int = 0; i < p_num; i++)
			{
				var m_y:	int = 25;
				var t_hit	:Sprite = new Sprite();
				var t_uhit	:Sprite = new Sprite();
				var t_name	:TextField = new TextField();
				var t_value	:TextField = new TextField();
				t_value.width = t_name.width = 100;
				t_value.height = t_name.height = 24;
				t_name.x = 20;
				t_value.x = t_name.x + t_value.width * 1.39;
				t_name.y = m_y * i + 230;
				t_value.y = t_name.y;
				t_hit.graphics.beginFill(0xFFFFFF);
				t_hit.graphics.drawRect(0,t_name.y,273,25);
				t_uhit.graphics.beginFill(0xFF794B,0);
				t_uhit.graphics.drawRect(0,t_name.y,273,25);
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
			m_bg.graphics.drawRect(0,0,273,64*m_value.length);
		}
		
		private function getTextFormat(param0:Boolean):TextFormat
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = m_main.display.main.data.FONT_NAME;
			textFormat.size = 14;
			textFormat.bold = true;
			param0 ? textFormat.align = TextFormatAlign.LEFT : textFormat.align = TextFormatAlign.RIGHT;
			return textFormat;
		}
		public function close(closeVisually:Boolean = false):void
		{
			for (var i:int = 0; i < m_upperhit.length; i++) 
			{
				removeGlow(i);
				m_upperhit[i].buttonMode = false;
				m_upperhit[i].removeEventListener(MouseEvent.CLICK,onTxtSelected);
				m_upperhit[i].removeEventListener(MouseEvent.ROLL_OUT,onTxtOverEtOut);
				m_upperhit[i].removeEventListener(MouseEvent.ROLL_OVER,onTxtOverEtOut);
				if (closeVisually)
				{
					if (m_back == null)
					{
						m_back = new Sprite();
						var bmp:Bitmap = new Bitmap;
						bmp.bitmapData = m_main.display.main.data.getBMPById(3).clone();
						m_back.addChild(bmp);
					}
					this.addChild(m_back);
				}
				else
				{
					if (m_back)
					{
						if (this.contains(m_back))
						{
							this.removeChild(m_back);
						}
					}
				}
			}
		}
		public function open():void
		{
			for (var i:int = 0; i < m_upperhit.length; i++) 
			{
				if (m_main.display.main.data.paramsIntera[i] == "true" && playAble)
				{
					m_upperhit[i].buttonMode = true;
					m_upperhit[i].addEventListener(MouseEvent.CLICK,onTxtSelected);
					m_upperhit[i].addEventListener(MouseEvent.ROLL_OVER,onTxtOverEtOut);
					m_upperhit[i].addEventListener(MouseEvent.ROLL_OUT,onTxtOverEtOut);
				}
			}
		}
		public function addGlow(index:int):void
		{
			var newcolor:ColorTransform = new ColorTransform();
			newcolor.color = 0xf1c018; 
			m_hit[index].transform.colorTransform = newcolor;
		}
		public function removeGlow(index:int):void
		{
			var newcolor:ColorTransform = new ColorTransform();
			newcolor.color = 0xFFFFFF; 
			m_hit[index].transform.colorTransform = newcolor;
		}
		
		protected function onTxtOverEtOut(event:MouseEvent):void
		{
			if (event.type == MouseEvent.ROLL_OVER)
			{
				var newcolor:ColorTransform = new ColorTransform();
				newcolor.color = 0xfbecb9; 
				m_hit[event.currentTarget.name].transform.colorTransform = newcolor;
			}
			else if (event.type == MouseEvent.ROLL_OUT)
			{
				removeGlow(event.currentTarget.name);
			}
		}
		protected function onTxtSelected(event:MouseEvent = null):void
		{
			addGlow(event.currentTarget.name);
			m_main.compareParams(event.currentTarget.name);
		}
		public function dispatchOn():void
		{
			if (!playAble)
			{
				var random:int = Math.floor(Math.random()*m_upperhit.length);
				var interactable:Boolean = m_main.display.main.data.paramsIntera[random] == "true";
				if (counter > 5 && interactable)
				{
					addGlow(random);
					m_main.compareParams(random);
					counter = 0;
				}
				else if (interactable && m_value[random].text != "0")
				{
					addGlow(random);
					m_main.compareParams(random);
					counter = 0;
				}
				else
				{
					counter++;
					dispatchOn();
				}
			}
		}
		public function removeBlink(nexts:Boolean = false):void
		{
			//m_bg.filters = original;
			if (nexts)m_main.next();
		}
		public function destroy():void
		{
			id				= 0;
			m_main			= null;
			m_bg			= null;
			m_back			= null;
			m_cont			= null;
			for (var i:int = 0; i < p_num; i++) 
			{
				m_value[i] = null;
				m_name[i]	   = null;
				m_hit[i]	   = null;
				m_upperhit[i]	   = null;
			}
			p_num	  = 0;
			m_name	  = null;
			m_value	  = null;
			m_hit	  = null;
			m_upperhit= null;
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
	}
}