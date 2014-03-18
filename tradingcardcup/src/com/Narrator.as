package com
{
	import com.greensock.TweenLite;

	public class Narrator
	{
		public var asset	:NarratorAsset;
		public var speechs	:Vector.<NarratorSpeech>;
		public var turn		:int = 0;
		public function Narrator()
		{
			asset = new NarratorAsset();
			speechs = new Vector.<NarratorSpeech>();
		}
		public function test():void
		{
			queue("E rola a bola..")
			queue("O time da casa toca a bola..")
			queue("Partida começa lenta..")
			queue("Os dois times se estudam..")
			queue("Zanardo dispara pela esquerda..")
			queue("Lança para Zidane..");
			queue("Ele roda sobre a defesa..");
			queue("Devolve para Zaza..");
			queue("Chuveirinho na area..");
			queue("Bibi sobe com Puyol..");
			queue("Venceu o goleiro!!!");
			queue("GOOOOOOOOOOOOOOOOOOOOOOOOOOL");
			queue("Uma pancada!!!");
			queue("Ele comemora sem camisa...");
			queue("E toma cartão amarelo!");
			queue("Bola no meio da cancha..");
			
		}
		public function play():void
		{
			if (asset)
			{
				if (asset.narratortxt)
				{
					if (speechs.length <= turn)
					{
						turn = 0;
					}
					asset.narratortxt.text = speechs[turn].text;
					TweenLite.delayedCall(speechs[turn].time, play);
					turn++;
				}
			}
		}
		public function queue(text:String, time:int = 2):void
		{
			var speech:NarratorSpeech = new NarratorSpeech(text, time);
			speechs.push(speech);
		}
		
	}
}