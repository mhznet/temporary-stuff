package com
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	public class Cidade
	{
		private var ordem:int = 0;
		public var arrayDePosicoesPerguntas:Array;
		private var xml:XML;
		public var cidadeNome:String;
		public var arrayDeQuestionarios:Array;
		public var pontuacaoFinal:int = 0; //Do jogador
		public var pontuacaoMedia:Number = 0; //Geral
		public var pontuacaoMediaString:String = "0.0";
		public var pontuacaoTotal:int = 0; //PontuacaoMaxima possivel a atingir na cidade
		public var valorPergunta:int = 1;
		private var foiRespondida:Boolean = false;
		public var mediaRandom:Boolean = false;
		
		public function Cidade():void
		{
		}
		
		public function getCidadePontuacaoTotal():int
		{
			pontuacaoTotal = 0;
			for each (var question:Questionario in arrayDeQuestionarios)
			{
				pontuacaoTotal += question.getValor();
			}
			//trace ("pontuacaoTotal:", pontuacaoTotal);
			return pontuacaoTotal;
		}
		
		public function setPontuacaoMedia(value:String):void
		{
			pontuacaoMedia = Number(value);
			//trace (this.cidadeNome + ": setPontuacaoMedia - ", value);
			/*if (Number(value) < 10)
			{
				value = 0 + value;
			}*/
			//trace (this.cidadeNome + ": setPontuacaoMediaString - ", value);
			pontuacaoMediaString = value;
		}
		public function getPontuacaoMediaString():String
		{
			return pontuacaoMediaString;
		}
		public function getPontuacaoMedia():Number
		{
			return pontuacaoMedia;
		}
		
		public function getPontuacaoFinal():String
		{
			return pontuacaoFinal.toString();
		}
		
		public function setPontuacaoFinal(value:int)
		{
			pontuacaoFinal = value;
		}
		
		public function addToPontuacao(value:int):void
		{
			pontuacaoFinal += value;
		}
		
		public function zerarPontuacaoFinal():void
		{
			pontuacaoFinal = 0;
		}
		
		public function getFoiRespondida():Boolean
		{
			return foiRespondida;
		}
		
		public function setFoiRespondida(value:Boolean):void
		{
			foiRespondida = value;
		}
		
		public function setOrdem(value:int):void
		{
			ordem = value;
		}
		
		public function getOrdem():int
		{
			return ordem;
		}
		
		public function fillQeA(lista:XML, arrayRecebido:Array):void
		{
			arrayDePosicoesPerguntas = arrayRecebido;
			xml = new XML(lista);
			arrayDeQuestionarios = new Array();
			cidadeNome = xml.cidade.@nome;
			//trace ("Preenchido:",cidadeNome, "com",xml.*[1].questionario.length(), "perguntas, cada uma com valor de", valorPergunta, "totalizando:", valorPergunta*xml.*[1].questionario.length());
			var numeroDePerguntas:int = xml.*[1].questionario.length();
			for (var i:uint = 0; i < numeroDePerguntas; i++)
			{
				var questionario:Questionario = new Questionario();
				questionario.setPergunta(xml.*[1].*[i].@pergunta);
				questionario.setRodapeTxt(xml.*[1].*[i].@rodape);
				//questionario.setValor(xml.*[1].*[i].@valor);
				questionario.setValor(valorPergunta);
				questionario.setOpcaoCerta(xml.*[2].*[i].@alternativaCerta);
				questionario.setOpcao("A", xml.*[2].*[i].*[0].@resposta);
				questionario.setOpcao("B", xml.*[2].*[i].*[1].@resposta);
				questionario.setOpcao("C", xml.*[2].*[i].*[2].@resposta);
				questionario.setOpcao("D", xml.*[2].*[i].*[3].@resposta);
				arrayDeQuestionarios.push(questionario);
				//trace("Pergunta:", questionario.getPergunta(), "\nOpcaoCerta:", questionario.getOpcaoCerta(), "\nOp.A:", questionario.getOpcao("A"), "\nOp.B:", questionario.getOpcao("B"), "\nOp.C:", questionario.getOpcao("C"), "\nOp.D:", questionario.getOpcao("D"));
			}
		}
	}
}