package com.scenes
{
	import com.ScheduleSystem;
	import com.globo.sitio.ResultAsset;
	import com.scenes.abstract.AbstractScene;
	import com.scenes.abstract.InputObject;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class ResultScene extends AbstractScene
	{
		private var inputObj:InputObject;
		private const L_TEXT:String = "ocupado";
		private const S_TEXT:String = "sucesso";
		private var bg:ResultAsset;
		private var returnBtn:Sprite;
		private var txtField:TextField;
		public function ResultScene(p_main:ScheduleSystem)
		{
			super(p_main);
			this.begin();
			this.createreturnBtn();
		}
		public function update(p_input:InputObject):void
		{
			this.inputObj = p_input;
			var text:String = "";
			//trace ("Success:", inputObj.m_hour != "13:00", "13:00", "==", inputObj.m_hour);
			mat == 1 ? text = S_TEXT : text = L_TEXT;
			if (this.bg)
			{
				if (this.contains(bg))
				{
					this.removeChild(this.bg);
					bg = null;
					this.begin();
					
					trace (this.bg.currentFrame, "ESTOU NESSE");
				}
				var mat:int = Math.floor(Math.random()*2)+1;
				trace("OLHA MEU VALOR AQUI:: " + mat);
				if(mat == 1)
				{
					trace ("Livre!");
					this.bg.gotoAndStop("sucesso");
				}else
				{
					trace ("Ocupado!");
					this.bg.gotoAndStop("ocupado");
				}
			}
		}
		
		private function begin():void
		{
			bg = new ResultAsset();
			bg.x = main.getWidth()*0.5;
			this.addChild(bg);
			this.bg.gotoAndPlay(1);
			/*txtField = new TextField();
			txtField.selectable = false;
			txtField.width = 200;
			txtField.height = 100;
			txtField.mouseEnabled = false;
			txtField.x = this.main.getWidth()*0.5 - txtField.width*0.5;
			txtField.y = this.main.getHeight()*0.4;
			this.addChild(txtField);*/
		}
		
		private function createreturnBtn():void
		{
			this.returnBtn = new BtAgainAsset();
			/*this.returnBtn.graphics.beginFill(0x99FF00, 1);
			this.returnBtn.graphics.drawCircle(30,30,50);
			this.returnBtn.graphics.endFill();*/
			this.returnBtn.mouseChildren = false;
			this.returnBtn.x = main.getWidth()*0.5;
			this.returnBtn.y = 380;
			this.addChild(this.returnBtn);
			this.returnBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.main.goToIntro();
		}
	}
}