package com.display.screens.match
{
	public class SpeechTypes
	{
		public var fullVector		:Vector.<NarratorSpeech>;

		public var JOGADOR_A		:String = "JOGADOR_ATK";
		public var JOGADOR_D		:String = "JOGADOR_DEF";
		public var TIME				:String = "TIME";
		public var SITUACAO			:String = "SITUACAO";
		
		public const ESQUERDA		:String = "pela esquerda";
		public const CENTRO			:String = "pelo meio";
		public const DIREITA		:String = "pela direita";
		
		
		//BEGIN
		public var interruptionVector		:Vector.<NarratorSpeech>;
		public var interruptionQuantity	:int = 7;
		public const INT_0:String = "Rasga a defesa..";
		public const INT_1:String = "E bola pro mato que o jogo é de campeonato..";
		public const INT_2:String = "É faltaaa, JOGADOR_DEF matou a jogada..";
		public const INT_3:String = "JOGADOR_DEF se aproveita e rouba a bola..";
		public const INT_4:String = "JOGADOR_DEF não quis saber, tirou a bola dali a qualquer custo!";
		public const INT_5:String = "JOGADOR_ATK vai ao chão, reclama com o juiz que não está nem ai! Segue o jogo.";
		public const INT_6:String = "O jogo já acabou? Parece, ninguém se apresenta...";
		public const INT_7:String = "JOGADOR_ATK cansou, parece que não acreditou na jogada..";
		
		//BEGIN
		public var beginVector		:Vector.<NarratorSpeech>;
		public var beginQuantity	:int = 11;
		public const BEGIN_0:String = "Segue a partida..";
		public const BEGIN_1:String = "Repõe a bola..";
		public const BEGIN_2:String = "JOGADOR bobeou e perdeu o dominio..";
		public const BEGIN_3:String = "As equipes se estudam...";
		public const BEGIN_4:String = "JOGADOR_DEF toca a bola de lado..";
		public const BEGIN_5:String = "JOGADOR_DEF recebe a bola..";
		public const BEGIN_6:String = "JOGADOR_ATK arrisca um lançamento..";
		public const BEGIN_7:String = "Bola enfiada..";
		public const BEGIN_8:String = "Pegou de surpresa! O contra-ataque tem um avenida a frente..";
		public const BEGIN_9:String = "Rola a bola..";
		public const BEGIN_10:String = "Muito gente bloqueando o caminho..";
		//MIDDLE
		public var middleVector		:Vector.<NarratorSpeech>;
		public var middleQuantity	:int = 11;
		public const MIDDLE_0:String = "Tentam uma triangulação..";
		public const MIDDLE_1:String = "Abre na lateral..";
		public const MIDDLE_2:String = "JOGADOR_ATK dribla o adversario, que desconcertante..";
		public const MIDDLE_3:String = "Chapelou o JOGADOR_DEF, que beleza!";
		public const MIDDLE_4:String = "Que triangulação bonita!, JOGADOR_ATK leu muito bem o lance..";
		public const MIDDLE_5:String = "Isso que é visão, achou JOGADOR_ATK livre..";
		public const MIDDLE_6:String = "Chuveirinho na area!";
		public const MIDDLE_7:String = "Lançamento em profundidade!";
		public const MIDDLE_8:String = "JOGADOR_ATK vai até a linha de fundo, vai cruzar!";
		public const MIDDLE_9:String = "A defesa só olha, o goleiro não acredita!";
		public const MIDDLE_10:String ="JOGADOR_ATK é futebol arte, passou como quis..";
		//END
		public var endVector		:Vector.<NarratorSpeech>;
		public var endQuantity		:int = 6;
		public const END_0:String = "Arranca na area! Chutooooooou...";
		public const END_1:String = "Um petardoooooo...";
		public const END_2:String = "Subiu mais alto, de cabeçaaa...";
		public const END_3:String = "É um voleio? Uma meia bicicleta? É demaiss!!";
		public const END_4:String = "Pegou de primeira.. fuzilaaa!!";
		public const END_5:String = "Não é possivel, um presente da defesa!";
		
		
		public function SpeechTypes()
		{
			fillInterruption();
			fillBeginners();
			fillMiddle();
			fillEnd();
		}
		
		private function fillInterruption():void
		{
			interruptionVector = new Vector.<NarratorSpeech>();
			for (var i:int = 0; i < interruptionQuantity; i++) 
			{
				var narr:NarratorSpeech = new NarratorSpeech(i,this["INT_"+i],2,10);
				interruptionVector.push(narr);
			}
		}
		
		private function fillEnd():void
		{
			endVector = new Vector.<NarratorSpeech>();
			for (var i:int = 0; i < endQuantity; i++) 
			{
				var narr:NarratorSpeech = new NarratorSpeech(i,this["END_"+i],2,10);
				endVector.push(narr);
			}
		}
		private function fillMiddle():void
		{
			middleVector = new Vector.<NarratorSpeech>();
			for (var i:int = 0; i < middleQuantity; i++) 
			{
				var narr:NarratorSpeech = new NarratorSpeech(i,this["MIDDLE_"+i],2,10);
				middleVector.push(narr);
			}
		}
		private function fillBeginners():void
		{
			beginVector = new Vector.<NarratorSpeech>();
			for (var i:int = 0; i < beginQuantity; i++) 
			{
				var narr:NarratorSpeech = new NarratorSpeech(i,this["BEGIN_"+i],2,10);
				beginVector.push(narr);
			}
		}
	}
}