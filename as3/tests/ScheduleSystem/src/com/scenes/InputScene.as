package com.scenes
{
	import com.ScheduleSystem;
	import com.scenes.abstract.AbstractScene;
	import com.scenes.abstract.InputObject;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class InputScene extends AbstractScene
	{
		public var inputObj:InputObject;
		public var nextSceneBtn:Sprite;
		public var textCont:Sprite;
		public var names:Array = ["nome", "telefone","email", "servico", "dataa", "hora"];
		public var statuses:Array = [];
		public var m_texts:Array = [];
		public var sprite:Array = [];
		
		public function InputScene(p_main:ScheduleSystem)
		{
			super(p_main);
			this.begin();
			this.createNextSceneBtn();
		}
		public function clear():void
		{
			if (nextSceneBtn != null) nextSceneBtn.visible = false;
			for (var i:int = 0; i < m_texts.length; i++) 
			{
				m_texts[i].text = "";
				statuses[i] = false;
			}
			m_texts = [];
			statuses = [];
			getTextFields();
		}
		private function begin():void
		{
			textCont = new TextBoxInput();
			this.textCont.x = main.getWidth()*0.5;
			this.addChild(textCont);
			
			getTextFields();
			
			/*for (var i:int = 0; i < names.length; i++) 
			{
				var spri:Sprite = new Sprite();
				var txtField:TextField = new TextField();
				txtField.type = TextFieldType.INPUT;
				txtField.addEventListener(Event.CHANGE, onActivate);
				txtField.x = 80;
				txtField.height = 50;
				txtField.width = 150;
				txtField.border = true;
				txtField.borderColor = 0x99FF00;
				txtField.needsSoftKeyboard = true;
				requestSoftKeyboard();
				txtField.y = (80 * i) + 30;
				m_texts.push(txtField);
				statuses.push(false);
				spri.addChild(txtField);
				var txt:TextField = new TextField();
				txt.type = TextFieldType.DYNAMIC;
				txt.text = names[i];
				txt.width = 50;
				txt.height = 50;
				txt.x = 10;
				txt.selectable = false;
				txt.mouseEnabled = false;
				txt.y = txtField.y;
				spri.addChild(txt);
				this.addChild(spri);
				sprite.push(spri);
			}*/
		}
		
		private function getTextFields():void
		{
			for (var i:int = 0; i < names.length; i++)
			{
				var textField:TextField = this.textCont.getChildByName(names[i]) as TextField;
				textField.addEventListener(Event.CHANGE, onActivate);
				//textField.addEventListener(Event.ACTIVATE, onReallyActivate);
				statuses.push(false);
				m_texts.push(textField);
			}
			trace (m_texts.length, "ahe");
		}
		
		protected function onReallyActivate(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.ACTIVATE, onReallyActivate);
			(event.currentTarget as TextField).text = "";
		}
		
		private function verify():Boolean
		{
			var rdy:Boolean = true;
			for (var i:int = 0; i < statuses.length; i++) 
			{
				if (statuses[i] == false)
				{
					rdy = false;
					break;
				}
			}
			return rdy;
		}
		protected function getTargetId(txt:TextField):int
		{
			var myId:int = 10;
			for (var i:int = 0; i < m_texts.length; i++) 
			{
				if (txt == m_texts[i])
				{
					myId = i;
				}
			}
			return myId;
		}
		protected function onActivate(event:Event):void
		{
			if (event.currentTarget.text != "")
			{
				var id:int = getTargetId(event.currentTarget as TextField); 
				if (id != 10)
				{
					statuses[id] = true;
				}
			}
			else
			{
				var id2:int = getTargetId(event.currentTarget as TextField); 
				if (id2 != 10)
				{
					statuses[id2] = false;
				}
			}
			if (verify() == true)
			{
				this.nextSceneBtn.visible = true;
				this.addEventListener(MouseEvent.CLICK, onClick);
			}
			else
			{
				this.nextSceneBtn.visible = false;
			}
		}
		
		private function createNextSceneBtn():void
		{
			this.nextSceneBtn = new BtNextAgendar();
			/*this.nextSceneBtn.graphics.beginFill(0x99FF00, 1);
			this.nextSceneBtn.graphics.drawCircle(30,30,50);
			this.nextSceneBtn.graphics.endFill();*/
			this.nextSceneBtn.mouseChildren = false;
			this.nextSceneBtn.x = main.getWidth()*0.5;
			this.nextSceneBtn.y = main.getHeight()*0.91;
			this.nextSceneBtn.visible = false;
			this.addChild(this.nextSceneBtn);
			this.nextSceneBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK, onClick);
			if (verify())
			{
				// 0,1,2,3,4,5
				// "nome", "telefone","email", "servico", "dataa", "hora"
				// inputObj = new InputObject(m_texts[0].text,m_texts[1].text,m_texts[2].text,m_texts[3].text,m_texts[4].text);
				var bool:Boolean = m_texts[5].text != "13:00";
				trace ("boool do success", bool, m_texts[0].text, m_texts[5].text);
				inputObj = new InputObject(bool, m_texts[5].text, m_texts[0].text);
				//inputObj.traceIt();
				this.main.goToResult(inputObj);
			}
		}
	}
}