package com.display.screens
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
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
		public var back_transition	:Sprite;
		public var m_cont			:Sprite;
		public var m_value			:Vector.<TextField>;
		public var m_name			:Vector.<TextField>;
		public var m_hit			:Vector.<Sprite>;
		public var m_upperhit		:Vector.<Sprite>;
		public var textFormat		:TextFormat;
		private var counter			:int=0;
		private var feedBackCont	:MovieClip;
		private var equal	:Sprite;
		private var won		:Sprite;
		private var lost	:Sprite;
		
		public function CardDetails(paramsNum:int, main:SingleGameScreen)
		{
			super();
			m_main = main;
			p_num = paramsNum;
			start();
		}
		private function showUpdate(t_name:Vector.<String> = null, t_value:Vector.<String> = null, spr:Sprite = null, isPlayable:Boolean = false):void
		{
			//playAble = isPlayable;
			//trace ("Porra", isPlayable);
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
		public function update(t_name:Vector.<String> = null, t_value:Vector.<String> = null, spr:Sprite = null, isPlayable:Boolean = false):void
		{
			if (!this.contains(back_transition)) this.addChild(back_transition);
			back_transition.alpha = 1;
			TweenLite.to(back_transition,1,{delay:0.5, alpha:0});
			TweenLite.delayedCall(1, showUpdate, [t_name, t_value, spr, isPlayable]);
			playAble = isPlayable;
		}
		private function start():void
		{
			back_transition = new Sprite();
			var bmp2:Bitmap = new Bitmap;
			bmp2.bitmapData = m_main.display.main.data.getBMPById(3).clone();
			back_transition.addChild(bmp2);
			back_transition.mouseEnabled = false;
			back_transition.mouseChildren = false;
			back_transition.alpha = 0;
			
			m_bg = new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF);
			this.addChild(m_bg);
			m_cont = new Sprite();
			m_cont.y = 14;
			m_cont.x = 14;
			this.addChild(m_cont);
			startFeedBack();
			m_name = new Vector.<TextField>();
			m_value = new Vector.<TextField>();
			m_hit = new Vector.<Sprite>();
			m_upperhit = new Vector.<Sprite>();
			for (var i:int = 0; i < p_num; i++)
			{
				var m_height:Number = 30;
				var t_hit	:Sprite = new Sprite();
				var t_uhit	:Sprite = new Sprite();
				var t_name	:TextField = new TextField();
				var t_value	:TextField = new TextField();
				//t_value.width = t_name.width = 100;
				t_value.height = t_name.height = m_height
				t_name.x = 20;1
				t_value.x = t_name.x + t_value.width * 1.39;
				t_name.y = m_height * i + 220;
				t_value.y = t_name.y;
				t_hit.graphics.beginFill(0xFFFFFF);
				t_hit.graphics.drawRect(0,t_name.y,271,m_height);
				t_uhit.graphics.beginFill(0xFF794B,0);
				t_uhit.graphics.drawRect(0,t_name.y,271,m_height);
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
			m_bg.graphics.drawRect(0,0,271,377/*64*m_value.length*/);
		}
		public function showProperFeedBack(status:int):void
		{
			var spr:Sprite;
			switch(status)
			{
				case -1:
					spr = lost;
					break;
				case 1:
					spr = won;
					break;
				case 0:
					spr = equal;
					break;
			}
			spr.alpha = 0;
			feedBackCont.addChild(spr);
			TweenLite.to(spr,0.5,{delay:1,alpha:1,onComplete:onFeedBackShown,onCompleteParams:[spr]});
		}
		private function onFeedBackShown(spr:Sprite):void
		{
			TweenLite.to(spr,0.5,{alpha:0,delay:1,onComplete:cleanFeedBack});
		}
		private function cleanFeedBack():void
		{
			while(feedBackCont.numChildren>0)
			{
				this.feedBackCont.removeChildAt(0);
			}
		}
		private function startFeedBack():void
		{
			feedBackCont = new MovieClip();
			feedBackCont.mouseEnabled=false;
			feedBackCont.mouseChildren=false;
			feedBackCont.x = 14;
			feedBackCont.y = 14;
			this.addChild(feedBackCont);
			
			won 	= new Sprite();
			var bg_cont_won:MovieClip = new MovieClip();
			var bg_won:Shape = new Shape();
			bg_won.graphics.beginFill(0x97cd03,1);
			bg_won.graphics.drawRect(0,0, 241,198);
			bg_won.graphics.endFill();
			bg_cont_won.addChild(bg_won);
			bg_cont_won.blendMode = BlendMode.MULTIPLY;
			var bmp	:Bitmap = new Bitmap();
			bmp.bitmapData = m_main.display.main.data.getBMPById(14);
			bmp.x = 120.5 - bmp.width*0.5;
			bmp.y = 99 - bmp.height*0.5;
			won.addChild(bg_cont_won);
			won.addChild(bmp);
			won.alpha = 0;
			
			lost	= new Sprite();
			var bg_cont_lost:MovieClip = new MovieClip();
			var bg_lost:Shape = new Shape();
			bg_lost.graphics.beginFill(0xd84b00,1);
			bg_lost.graphics.drawRect(0,0, 241,198);
			bg_lost.graphics.endFill();
			bg_cont_lost.addChild(bg_lost);
			bg_cont_lost.blendMode = BlendMode.MULTIPLY;
			var bmp2:Bitmap = new Bitmap();
			bmp2.bitmapData = m_main.display.main.data.getBMPById(15);
			bmp2.x = 120.5- bmp2.width*0.5;
			bmp2.y = 99 - bmp2.height*0.5;;
			lost.addChild(bg_cont_lost);
			lost.addChild(bmp2);
			lost.alpha = 0;
			
			equal	= new Sprite();
			var bg_cont_equal:MovieClip = new MovieClip();
			var bg_equal:Shape = new Shape();
			bg_equal.graphics.beginFill(0xeebf00,1);
			bg_equal.graphics.drawRect(0,0, 241,198);
			bg_equal.graphics.endFill();
			bg_cont_equal.addChild(bg_equal);
			bg_cont_equal.blendMode = BlendMode.MULTIPLY;
			var bmp3:Bitmap = new Bitmap();
			bmp3.bitmapData = m_main.display.main.data.getBMPById(16);
			bmp3.x = 120.5 - bmp3.width*0.5;
			bmp3.y = 99 - bmp3.height*0.5;
			equal.addChild(bg_cont_equal);
			equal.addChild(bmp3);
			equal.alpha = 0;
		}
		
		private function getTextFormat(param0:Boolean):TextFormat
		{
			if (!textFormat)
			{
				textFormat = new TextFormat();
				textFormat.font = "BebasNeue";
				textFormat.size = 24.8/*23*/;
				textFormat.bold = true;
				textFormat.kerning = true;
			}
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