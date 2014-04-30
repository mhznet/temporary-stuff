package com
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import com.adobe.serialization.json.JSON
	import fl.controls.TextArea;
	
	public class ControladorDeTelas extends MovieClip
	{
		private var main:Main = null;
		private var telaAtual:String = "";
		public var paginaIntro:MovieClip = null;
		public var paginaLogin:MovieClip = null;
		public var paginaAbout:MovieClip = null;
		public var paginaSelection:MovieClip = null;
		public var paginaQuiz:MovieClip = null;
		public var paginaResults:MovieClip = null;
		public var paginaCitiesRanking:MovieClip = null;
		
		private var cidadeEscolhida:Cidade = null;
		private var perguntasRespondidas:int = 0;
		private var numeroDeBarrasCompletadas:int = 0;
		private var liberaOverAndOutNasBarras:Boolean = false;
		public var liberaAddEventosNaAbout:Boolean = false;
		public var arrayDeOpcoes:Array = null; // Array com as opções A, B, C, D de respostas;
		public var arrayDeCidades:Array = new Array(); // Array normal com todas as cidades
		public var arrayDeBotoes:Array = null; // Array MATRIZ com os botoes da cidade na tela de seleção
		public var arrayDeCidadesSelecionaveis:Array = null; // Array normal com os botoes da cidade na tela de seleção
		private var timer:Timer = null;
		private var timerTempo:int = 30;
		private var bandeirasExibidas:Boolean = false; // Se existe alguma bandeira exibida nas opçcoes de resposta
		private var alternativaEscolhida:Boolean = false;
		private var botaoCidadeEscolhida:MovieClip; // Botao da sua cidade escolhida no graficos finais de resultado;
		private var bubbleSorted:Boolean = false; // se o arrayDecidaddes ja foi bubblesorted
		
		public var facebookUserClass:FacebookUserClass;
		
		public function ControladorDeTelas():void
		{
			TweenPlugin.activate([GlowFilterPlugin]);
		}
		
		public function iniciar(cidades:Main):void
		{
			trace("[ControladorDeTelas] - New");
			this.main = cidades;
			if (!main.isLocal)
			{
				trace("[Facebook Init]");
				facebookUserClass = new FacebookUserClass();
				//facebookUserClass.init("446131938761904", "0cec09df9b0f9dc5879f19fa30162873", true, this.outputTxt);
				facebookUserClass.init("389910297743963", "b9a39ddcd738ebf04c0524fea03d2ce9");
				facebookUserClass.activateCallBackFunctions(callBackUserJaConectado, callBackUserLogin, callBackUserData);
				facebookUserClass.setPermissions("publish_actions, publish_stream, user_birthday");
				//clearButton.addEventListener(MouseEvent.CLICK, onClickClearOutput);
			}
			goToIntro();
		}
		
		public function callBackUserJaConectado(mensagem:String, result:Object):void
		{
			var resultado:String = JSON.encode(result);
			//outputTxt.appendText("callBackUserJaConectado" + result + " " + mensagem);
			trace("FB: callBackUserJaConectado" + mensagem, resultado);
			if (mensagem == "Success")
			{
				facebookUserClass.loadUserInfo(); // vai pro callBackUserData
			}
			else
			{
				//else espera ele clicar no btNext e ir pro goToLogin()
			}
		}
		
		private function callBackUserLogin(mensagem:String, result:Object):void
		{
			var resultado:String = JSON.encode(result);
			//outputTxt.appendText("callBackUserLogin" + resultado +" "+ mensagem);
			if (mensagem == "Success")
			{
				facebookUserClass.loadUserInfo(); // vai pro callBackUserData
			}
		}
		
		private function onClickClearOutput(e:MouseEvent):void
		{
			//outputTxt.text = "";
		}
		
		public function callBackUserData(mensagem:String, result:Object):void
		{
			var jsonString:String = JSON.encode(result);
			trace("[Facebook] - callBackUserData" + mensagem, jsonString);
			var jsonObj:Object = JSON.decode(jsonString);
			//this.outputTxt.appendText("\n@@@@@@: " + String(jsonObj) + jsonString);
			
			if (mensagem == "Success")
			{
				main.userErrado = false;
				//this.outputTxt.appendText("\n22222: " + result.id + result.name + result.gender + result.birthday + result.hometown);
				main.facebookUser_Sex = result.gender;
				main.facebookUser_Name = result.name;
				main.facebookUser_Id = result.id;
				main.facebookUser_City = result.hometown;
				main.facebookUser_Date = result.birthday;
				main.falarComServer.addUsuario(result.id, result.name, result.birthday, result.hometown, result.gender);
			}
			else
			{
				main.userErrado = true;
				main.falarComServer.atualizarDados();
			}
		}
		
		private function goToIntro():void
		{
			trace("[ControladorDeTelas] - goToIntro()");
			this.gotoAndStop("intro");
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaInicial");
			paginaIntro = MovieClip(getChildByName("pagIntro"));
			paginaIntro.btJogar.gotoAndStop("loading");
			
			paginaIntro.logoMC.scaleX = pagIntro.logoMC.scaleY = 0;
			TweenLite.to(paginaIntro.logoMC, 0.5, {scaleX: 2.05, scaleY: 2.05, ease: Back.easeOut});
			TweenLite.delayedCall(0.5, ativarAnimacaoLogo);
		}
		
		public function addEventosNaIntro():void
		{
			trace("[ControladorDeTelas] - addEventosNaIntro()");
			paginaIntro.btJogar.gotoAndStop("iniciar");
			paginaIntro.btJogar.addEventListener(MouseEvent.CLICK, goToLogin);
			paginaIntro.btJogar.addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaIntro.btJogar.addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			paginaIntro.btJogar.buttonMode = true;
			paginaIntro.btJogar.mouseChildren = false;
		}
		
		private function ativarAnimacaoLogo():void
		{
			TweenLite.to(paginaIntro.logoMC, 0.5, {scaleX: 2, scaleY: 2, ease: Back.easeInOut, onComplete: function()
				{
					TweenLite.to(paginaIntro.logoMC, 0.5, {scaleX: 2.05, scaleY: 2.05, ease: Back.easeInOut, delay: 3, onComplete: ativarAnimacaoLogo});
				}})
		}
		
		private function goToLogin(e:MouseEvent):void
		{
			trace("[ControladorDeTelas] - goToLogin()");
			if (!main.isLocal)
			{
				trace("[FaceBook] - loadLogin");
				facebookUserClass.loadLogin(); // callBackUserLogin
			}
			else
			{
				//adicionaru ser ao server
				main.falarComServer.addUsuario(main.facebookUser_Id, main.facebookUser_Name, main.facebookUser_Date, main.facebookUser_City, main.facebookUser_Sex);
			}
			this.goToAbout(); // mas sem habilitar o botaode prosseguir, esse só depois de logado e user no servidor
		}
		
		private function goToAbout():void
		{
			TweenLite.killTweensOf(paginaIntro.logoMC);
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaIntroducao");
			trace("[ControladorDeTelas] - goToAbout()");
			this.gotoAndStop("about");
			this.paginaAbout = MovieClip(getChildByName("pagAbout"));
			//this.paginaAbout.btNext.addEventListener(MouseEvent.CLICK, goToSelection);
			
			paginaAbout.tituloMC.alpha = 0;
			paginaAbout.subtituloMC.alpha = 0;
			paginaAbout.btNext.alpha = 0.3;
			paginaAbout.btNext.gotoAndStop("load");
			
			TweenLite.to(paginaAbout.tituloMC, 1, {alpha: 1, ease: Cubic.easeOut, delay: 0});
			TweenLite.to(paginaAbout.tituloMC, 1, {alpha: 1, ease: Cubic.easeOut, delay: 0});
			TweenLite.to(paginaAbout.subtituloMC, 1, { alpha: 1, ease: Cubic.easeOut, delay: 0.25 } );
			
			if (liberaAddEventosNaAbout)
			{
				trace ("CTD: liberaAddEventosNaAbout pela booleana");
				addEventosDaPaginaAbout();
			}
		}
		
		public function addEventosDaPaginaAbout():void
		{
			if (paginaAbout)
			{
				trace("[ControladorDeTelas] - addEventosDaPaginaAbout", this.paginaAbout, this.paginaAbout.btNext);
				this.paginaAbout.btNext.gotoAndStop("next");
				this.paginaAbout.btNext.addEventListener(MouseEvent.CLICK, goToSelection);
				TweenLite.to(paginaAbout.btNext, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 0.5, onComplete: addEventosBotao});
			}
		}
		
		private function addEventosBotao():void
		{
			paginaAbout.btNext.addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			paginaAbout.btNext.addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaAbout.btNext.buttonMode = true;
		}
		
		private function goToSelection(e:MouseEvent = null):void
		{
			trace("[ControladorDeTelas] - goToSelection()");
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaSelecaoCidade");
			this.gotoAndStop("selection");
			paginaSelection = MovieClip(getChildByName("pagSelection"));
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).visible = false;
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).alpha = 0;
			MovieClip(paginaSelection.getChildByName("btNext")).alpha = 0.5;
			MovieClip(paginaSelection.getChildByName("btNext")).buttonMode = false;
			if (!bubbleSorted)
			{
				bubbleSortNoArrayDeCidades();
			}
			exibirCidadesSelecionaveis();
		}
		
		private function bubbleSortNoArrayDeCidades():void
		{
			for (var bubbleSort:int = arrayDeCidades.length; bubbleSort >= 0; bubbleSort--)
			{
				for (var jota:int = 1; jota < bubbleSort; jota++)
				{
					var aux:Cidade;
					if (arrayDeCidades[jota].getOrdem() < arrayDeCidades[jota - 1].getOrdem())
					{
						aux = arrayDeCidades[jota - 1];
						arrayDeCidades[jota - 1] = arrayDeCidades[jota];
						arrayDeCidades[jota] = aux;
					}
				}
			}
			
			if (!main.isLocal)
			{
				/*for (var i:int = 0; i < arrayDeCidades.length; i++)
				   {
				   trace("[bubbleSort Results]", arrayDeCidades[i].cidadeNome, arrayDeCidades[i].getOrdem());
				   this.outputTxt.appendText("[bubbleSort Results] " + arrayDeCidades[i].cidadeNome + ", " + arrayDeCidades[i].getOrdem());
				 }*/
			}
		
		}
		
		private function goToQuiz(e:MouseEvent):void
		{
			trace("[ControladorDeTelas] - goToQuiz()");
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaQuiz");
			this.gotoAndStop("quiz");
			this.paginaQuiz = MovieClip(getChildByName("pagQuiz"));
			TextField(this.paginaQuiz.getChildByName("nomeDaCidade")).text = cidadeEscolhida.cidadeNome;
			MovieClip(paginaQuiz.getChildByName("btNext")).alpha = 0.5;
			MovieClip(paginaQuiz.getChildByName("btNext")).buttonMode = false;
			addPerguntasEAlternativas();
		}
		
		private function goToResults(e:MouseEvent):void
		{
			liberaOverAndOutNasBarras = false;
			numeroDeBarrasCompletadas = 0;
			trace("[ControladorDeTelas] - goToResults()");
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaResultado");
			this.gotoAndStop("results");
			this.paginaResults = MovieClip(getChildByName("pagResults"));
			var pontoGraficoMaximoY:Number = this.paginaResults.getChildByName("referenciaMaxima").y;
			var pontoGraficoMinimoY:Number = this.paginaResults.getChildByName("referenciaMinima").y;
			
			var assetPontuacaoCidade:MovieClip = MovieClip(this.paginaResults.getChildByName("mcPontuacaoCidade"));
			var assetPontuacaoGeral:MovieClip = MovieClip(this.paginaResults.getChildByName("mcPontuacaoGeral"));
			var assetMediaCidade:MovieClip = MovieClip(this.paginaResults.getChildByName("mcMediaCidade"));
			var assetMediaGeral:MovieClip = MovieClip(this.paginaResults.getChildByName("mcMediaGeral"));
			
			/*if (this.cidadeEscolhida.getPontuacaoMedia() == 0)
			{
				var random:int = Math.ceil (Math.random() * 19);
				var randomString:String = String(random);
				if (random < 10)
				{
					randomString += ".0";
				}
				trace ("RandomNum pra PontuacaoMedia", random, randomString);
				this.cidadeEscolhida.setPontuacaoMedia(randomString);
				this.cidadeEscolhida.mediaRandom = true;
			}
			if (main.getPontuacaoMediaTodasCidades() == 0)
			{
				var randomTotal:int = Math.ceil (Math.random() * 15);
				trace ("randomTotal pra PontuacaoMEdiaTodasCidades:", randomTotal);
				main.setPontuacaoMediaTodasCidades(randomTotal);
			}*/
			var pontuacaoJogador:int = int(this.cidadeEscolhida.getPontuacaoFinal());
			var pontuacaoMediaCidade:int = this.cidadeEscolhida.getPontuacaoMedia();
			var pontuacaoTotalCidade:int = this.cidadeEscolhida.getCidadePontuacaoTotal();
			var pontuacaoMediaGeral:int = main.getPontuacaoMediaTodasCidades();
			var pontuacaoTotalGeral:int = this.cidadeEscolhida.getCidadePontuacaoTotal();
			
			if (pontuacaoJogador > 20)
			{
				pontuacaoJogador = 20;
			}
			if (pontuacaoMediaCidade > 20) 
			{
				pontuacaoMediaCidade = 20;
			}
			if (pontuacaoTotalCidade > 20) 
			{
				pontuacaoTotalCidade = 20;
			}
			if (pontuacaoTotalGeral > 20)
			{
				pontuacaoTotalGeral = 20;
			}
			
			assetPontuacaoCidade.y 	= pontoGraficoMinimoY;
			assetMediaCidade.y 		= pontoGraficoMinimoY;
			assetPontuacaoGeral.y 	= pontoGraficoMinimoY;
			assetMediaGeral.y 		= pontoGraficoMinimoY;
			//trace ("Referencia Minima e Maxima", pontoGraficoMinimoY, pontoGraficoMaximoY);
			//trace ("Y :", assetPontuacaoCidade.y, assetMediaCidade.y, assetPontuacaoGeral.y, assetMediaGeral.y);
			
			var assetMediaGeralNewPosY:int = pontoGraficoMinimoY - ((pontuacaoMediaGeral / pontuacaoTotalGeral) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			var assetMediaCidadeNewPosY:int = pontoGraficoMinimoY - ((pontuacaoMediaCidade / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			
			var assetPontuacaoCidadeNewPosY:int = pontoGraficoMinimoY - ((pontuacaoJogador / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			var assetPontuacaoGeralNewPosY:int = pontoGraficoMinimoY - ((pontuacaoJogador / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			
			//trace ("Novo Y da Galere:", assetPontuacaoCidadeNewPosY, assetMediaCidadeNewPosY, assetPontuacaoGeralNewPosY, assetMediaGeralNewPosY);
			
			TweenLite.to(assetPontuacaoCidade, 1, {y: assetPontuacaoCidadeNewPosY, ease: Back.easeOut, delay: 0.5});
			TweenLite.to(assetMediaCidade, 1, {y: assetMediaCidadeNewPosY, ease: Back.easeOut, delay: 0.75});
			
			TweenLite.to(assetPontuacaoGeral, 1, {y: assetPontuacaoGeralNewPosY, ease: Back.easeOut, delay: 1.5});
			TweenLite.to(assetMediaGeral, 1, {y: assetMediaGeralNewPosY, ease: Back.easeOut, delay: 1.75});
			
			/*assetMediaGeral.y -= ((pontuacaoMediaGeral / pontuacaoTotalGeral) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			   assetMediaCidade.y -= ((pontuacaoMediaCidade / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			
			   assetPontuacaoCidade.y -= ((pontuacaoJogador / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));
			 assetPontuacaoGeral.y -= ((pontuacaoJogador / pontuacaoTotalCidade) * ((pontoGraficoMinimoY - pontoGraficoMaximoY)));*/
			var pontFinal:String = cidadeEscolhida.getPontuacaoFinal();
			var pontTotal:String = String(cidadeEscolhida.getCidadePontuacaoTotal());
			if (int(pontFinal) > int(pontTotal))
			{
				pontFinal = pontTotal;
			}
			
			TextField(this.paginaResults.getChildByName("nomeDaCidade")).text = cidadeEscolhida.cidadeNome;
			TextField(this.paginaResults.getChildByName("pontuacaoFinal")).text = pontFinal + "/" + pontTotal;
			
			MovieClip(paginaResults.getChildByName("share_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("challenge_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("choose_btn")).buttonMode = true;
			
			MovieClip(paginaResults.getChildByName("share_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("share_btn")).addEventListener(MouseEvent.CLICK, onClickFacebookShareResults);
			MovieClip(paginaResults.getChildByName("share_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaResults.getChildByName("share_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaResults.getChildByName("challenge_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("challenge_btn")).addEventListener(MouseEvent.CLICK, onClickChallengeFriends);
			MovieClip(paginaResults.getChildByName("challenge_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaResults.getChildByName("challenge_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaResults.getChildByName("choose_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("choose_btn")).addEventListener(MouseEvent.CLICK, onClickChooseAnotherCity);
			MovieClip(paginaResults.getChildByName("choose_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaResults.getChildByName("choose_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaResults.getChildByName("rankingCities_btn")).buttonMode = true;
			MovieClip(paginaResults.getChildByName("rankingCities_btn")).addEventListener(MouseEvent.CLICK, gotoCitiesRanking);
			MovieClip(paginaResults.getChildByName("rankingCities_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaResults.getChildByName("rankingCities_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
		}
		
		private function gotoCitiesRanking(e:MouseEvent):void
		{
			trace("[ControladorDeTelas] - gotoCitiesRanking()");
			this.gotoAndStop("citiesRanking");
			//if (!main.isLocal)main.tracker.trackPageview("/conhecidade/paginaRankingTodasCidades");
			this.paginaCitiesRanking = MovieClip(getChildByName("pagCitiesRanking"));
			for (var i:int = 0; i < arrayDeCidades.length; i++)
			{
				var cidadeBotao:CidadeResultado = new CidadeResultado();
				//cidadeBotao.mouseChildren = false;
				cidadeBotao.y = 410;
				cidadeBotao.x = 90 + (21 * i);
				var graficoBar:MovieClip = MovieClip(cidadeBotao.getChildByName("barraGfx"));
				graficoBar.mouseEnabled = false;
				var mcMouseOver:MovieClip = MovieClip(cidadeBotao.getChildByName("mOver"));
				//trace ("mcMouseOver", mcMouseOver);
				mcMouseOver.alpha = 0;
				mcMouseOver.visible = false;
				mcMouseOver.mouseChildren = false;
				mcMouseOver.mouseEnabled = false;
				mcMouseOver.buttonMode = false;
				
				graficoBar.height = 5;
				var textInside:TextField = TextField(cidadeBotao.getChildByName("cidadeNameTxt"));
				var alturaBarra:int;
				/*if (arrayDeCidades[i].getPontuacaoMedia() == 0)
				{
					if (!arrayDeCidades[i].mediaRandom)
					{
						var alturaBarraRandom:int = Math.ceil(Math.random() * 19);
						var stringAlturaBar:String = String(alturaBarraRandom);
						stringAlturaBar += ".0";
						arrayDeCidades[i].setPontuacaoMedia(stringAlturaBar);
						arrayDeCidades[i].mediaRandom = true;
						trace ("alturaBaraReserva em", arrayDeCidades[i].cidadeNome, alturaBarraRandom, stringAlturaBar);
					}
				} */
				alturaBarra = arrayDeCidades[i].getPontuacaoMedia();
				var pontoMedia:String = arrayDeCidades[i].getPontuacaoMediaString();
				TextField(mcMouseOver.getChildByName("mOverTxt")).text = String(pontoMedia);
				/*if (arrayDeCidades[i].mediaRandom)
				{
					trace ("Fim Barras:", arrayDeCidades[i].cidadeNome,alturaBarra, pontoMedia);
				}*/
				//TweenLite.to(graficoBar, 1, { height: alturaBarra, ease: Back.easeOut, delay: 0.5 + (0.1 * i) } );
				
				//ÚTIL
				TweenLite.to(graficoBar, 1, {height: alturaBarra * 5, ease: Back.easeOut, delay: 0.5 + (0.1 * i), onComplete: function()
					{
						numeroDeBarrasCompletadas++;
					}});
				
				mcMouseOver.y = 15;
				//trace("mcMouseOver.y", mcMouseOver.y);
				//graficoBar.height = Number(arrayDeCidades[i].getPontuacaoMedia());
				textInside.text = arrayDeCidades[i].cidadeNome;
				cidadeBotao.name = arrayDeCidades[i].cidadeNome
				if (cidadeBotao.name == cidadeEscolhida.cidadeNome)
				{
					botaoCidadeEscolhida = cidadeBotao as MovieClip;
					graficoBar.gotoAndStop("sua");
					mcMouseOver.gotoAndStop("sua");
				}
				else
				{
					graficoBar.gotoAndStop("outras");
					mcMouseOver.gotoAndStop("outras");
				}
				this.paginaCitiesRanking.addChild(cidadeBotao);
				cidadeBotao.getChildByName("overAqui").addEventListener(MouseEvent.MOUSE_OVER, overOutCidadeBotao);
				cidadeBotao.getChildByName("overAqui").addEventListener(MouseEvent.MOUSE_OUT, overOutCidadeBotao);
				MovieClip(cidadeBotao.getChildByName("overAqui")).buttonMode = true;
			}
			
			TextField(this.paginaCitiesRanking.getChildByName("nomeDaCidade")).text = cidadeEscolhida.cidadeNome;
			
			MovieClip(paginaCitiesRanking.getChildByName("share_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("challenge_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("choose_btn")).buttonMode = true;
			
			MovieClip(paginaCitiesRanking.getChildByName("share_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("share_btn")).addEventListener(MouseEvent.CLICK, onClickFacebookShareResults);
			MovieClip(paginaCitiesRanking.getChildByName("share_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaCitiesRanking.getChildByName("share_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaCitiesRanking.getChildByName("challenge_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("challenge_btn")).addEventListener(MouseEvent.CLICK, onClickChallengeFriends);
			MovieClip(paginaCitiesRanking.getChildByName("challenge_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaCitiesRanking.getChildByName("challenge_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaCitiesRanking.getChildByName("choose_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("choose_btn")).addEventListener(MouseEvent.CLICK, onClickChooseAnotherCity);
			MovieClip(paginaCitiesRanking.getChildByName("choose_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaCitiesRanking.getChildByName("choose_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			MovieClip(paginaCitiesRanking.getChildByName("back_btn")).buttonMode = true;
			MovieClip(paginaCitiesRanking.getChildByName("back_btn")).addEventListener(MouseEvent.CLICK, goToResults);
			MovieClip(paginaCitiesRanking.getChildByName("back_btn")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaCitiesRanking.getChildByName("back_btn")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
		}
		
		private function overOutCidadeBotao(e:MouseEvent):void
		{
			//trace ("CDT: numeroDeBarrasCompletadas", numeroDeBarrasCompletadas, "de", arrayDeCidades.length);
			if (numeroDeBarrasCompletadas == arrayDeCidades.length)
			{
				liberaOverAndOutNasBarras = true;
				numeroDeBarrasCompletadas = 0;
			}
			if (liberaOverAndOutNasBarras)
			{
				//trace("overOutCidadeBotao:", e.target.name, e.currentTarget.name);
				var mcTarget:MovieClip = MovieClip(e.currentTarget.parent);
				var mcOver:MovieClip = MovieClip(mcTarget.getChildByName("mOver"));
				var mcBar:MovieClip = MovieClip(mcTarget.getChildByName("barraGfx"));
				
				if (e.type == MouseEvent.MOUSE_OUT)
				{
					if (mcTarget.name != botaoCidadeEscolhida.name)
					{
						mcBar.gotoAndStop("outras");
					}
					else
					{
						mcBar.gotoAndStop("sua");
					}
					TweenLite.killTweensOf(mcBar);
					TweenMax.killTweensOf(mcOver);
					
					TweenLite.to(mcOver, 0.5, {alpha: 0, y: -15, ease: Cubic.easeOut, onComplete: function()
						{
							mcOver.visible = false
						}});
					TweenMax.to(mcBar, 0, {glowFilter: {color: 0x000000, alpha: 0, blurX: 1, blurY: 1, strength: 0, quality: 2}});
				}
				else if (e.type == MouseEvent.MOUSE_OVER)
				{
					//botaoCidadeEscolhida.barraGfx.gotoAndStop("outras");
					/*if (mcTarget.name != botaoCidadeEscolhida.name)
					   {
					   mcBar.gotoAndStop("over");
					   }
					   else
					   {
					   mcBar.gotoAndStop("suaSelecionada");
					 }*/
					mcOver.visible = true;
					
					TweenLite.killTweensOf(mcBar);
					TweenMax.killTweensOf(mcOver);
					
					TweenLite.to(mcOver, 0.5, {alpha: 1, y: (mcBar.y - mcBar.height), ease: Cubic.easeOut, delay: 0.2});
					TweenMax.to(mcBar, 0, {glowFilter: {color: 0x000000, alpha: 1, blurX: 3, blurY: 3, strength: 10, quality: 1}});
				}
			}
		}
		
		private function onClickFacebookShareResults(e:MouseEvent):void
		{
			facebookUserClass.loadPostToWall("<b>Você conhece as capitais brasileiras?</b>", "http://facebook.revistaglamour.globo.com/conhecidade/img/logo.jpg", "Fiz <b>" + cidadeEscolhida.getPontuacaoFinal() + "</b> pontos no questionário de <b>" + cidadeEscolhida.cidadeNome + "</b>", "E você? Conhece bem a sua cidade?<center></center>Faça o teste!", "http://apps.facebook.com/conhecidade/");
		}
		
		private function onClickChallengeFriends(e:MouseEvent):void
		{
			facebookUserClass.loadInviteFriends("Teste seus conhecimentos sobre as 27 capitais!", "Acesse: http://apps.facebook.com/conhecidade/ e responda ao questionário sobre sua cidade!");
		}
		
		private function onClickChooseAnotherCity(e:MouseEvent):void
		{
			numeroDeBarrasCompletadas = 0;
			liberaOverAndOutNasBarras = false;
			goToSelection();
			perguntasRespondidas = 0;
			alternativaEscolhida = false;
		}
		
		private function addPerguntasEAlternativas(e:MouseEvent = null):void
		{
			//trace ("Perguntas Respondidas:", perguntasRespondidas);
			//trace ("Resposta:", cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcaoCerta());
			alternativaEscolhida = false;
			arrayDeOpcoes = new Array;
			arrayDeOpcoes.push(MovieClip(this.paginaQuiz.getChildByName("opcaoA")), MovieClip(this.paginaQuiz.getChildByName("opcaoB")), MovieClip(this.paginaQuiz.getChildByName("opcaoC")), MovieClip(this.paginaQuiz.getChildByName("opcaoD")));
			for (var i:uint = 0; i < arrayDeOpcoes.length; i++)
			{
				arrayDeOpcoes[i].checkBox.gotoAndStop("off");
			}
			
			MovieClip(paginaQuiz.getChildByName("btNext")).alpha = 0.3;
			MovieClip(paginaQuiz.getChildByName("btNext")).buttonMode = false;
			MovieClip(paginaQuiz.getChildByName("btNext")).removeEventListener(MouseEvent.CLICK, addPerguntasEAlternativas);
			MovieClip(paginaQuiz.getChildByName("btNext")).removeEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			MovieClip(paginaQuiz.getChildByName("btNext")).removeEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			
			TextField(this.paginaQuiz.getChildByName("perguntaNumero_txt")).text = String(perguntasRespondidas + 1 + "/20");
			MovieClip(this.paginaQuiz.getChildByName("perguntaMC")).alpha = 0;
			TextField(MovieClip(this.paginaQuiz.getChildByName("perguntaMC")).getChildByName("perguntaText")).text = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getPergunta();
			
			var respostaA:String = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcao("A");
			var respostaB:String = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcao("B");
			var respostaC:String = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcao("C");
			var respostaD:String = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcao("D");
			
			var opcaoA:MovieClip = MovieClip(this.paginaQuiz.getChildByName("opcaoA"));
			var opcaoB:MovieClip = MovieClip(this.paginaQuiz.getChildByName("opcaoB"));
			var opcaoC:MovieClip = MovieClip(this.paginaQuiz.getChildByName("opcaoC"));
			var opcaoD:MovieClip = MovieClip(this.paginaQuiz.getChildByName("opcaoD"));
			
			opcaoA.alpha = 0;
			opcaoB.alpha = 0;
			opcaoC.alpha = 0;
			opcaoD.alpha = 0;
			
			TweenLite.to(MovieClip(this.paginaQuiz.getChildByName("perguntaMC")), 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 0.4});
			TweenLite.to(opcaoA, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 0.8});
			TweenLite.to(opcaoB, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 0.95});
			TweenLite.to(opcaoC, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 1.1});
			TweenLite.to(opcaoD, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 1.25});
			
			if ((respostaA.substr((respostaA.length - 4), respostaA.length)) == ".png" && !bandeirasExibidas)
			{
				bandeirasExibidas = true;
				opcaoA.addChild(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getBandeira("A"));
				opcaoB.addChild(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getBandeira("B"));
				opcaoC.addChild(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getBandeira("C"));
				opcaoD.addChild(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getBandeira("D"));
				
				TextField(opcaoA.getChildByName("alternativaText")).text = "";
				TextField(opcaoB.getChildByName("alternativaText")).text = "";
				TextField(opcaoC.getChildByName("alternativaText")).text = "";
				TextField(opcaoD.getChildByName("alternativaText")).text = "";
			}
			else
			{
				if (bandeirasExibidas)
				{
					opcaoA.removeChild(opcaoA.getChildByName(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas - 1] - 1].getBandeira("A").name));
					opcaoB.removeChild(opcaoB.getChildByName(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas - 1] - 1].getBandeira("B").name));
					opcaoC.removeChild(opcaoC.getChildByName(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas - 1] - 1].getBandeira("C").name));
					opcaoD.removeChild(opcaoD.getChildByName(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas - 1] - 1].getBandeira("D").name));
					bandeirasExibidas = false;
				}
				TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoA")).getChildByName("alternativaText")).text = respostaA;
				TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoB")).getChildByName("alternativaText")).text = respostaB;
				TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoC")).getChildByName("alternativaText")).text = respostaC;
				TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoD")).getChildByName("alternativaText")).text = respostaD;
			}
			
			MovieClip(this.paginaQuiz.getChildByName("rodapeMC")).alpha = 0;
			MovieClip(this.paginaQuiz.getChildByName("rodapeMC")).rodapeTxt.text = cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getRodape();
			TweenLite.to(MovieClip(this.paginaQuiz.getChildByName("rodapeMC")), 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 1.4});
			
			var textoAlinhadoA:TextField = TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoA")).getChildByName("alternativaText"));
			var textoAlinhadoB:TextField = TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoB")).getChildByName("alternativaText"));
			var textoAlinhadoC:TextField = TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoC")).getChildByName("alternativaText"));
			var textoAlinhadoD:TextField = TextField(MovieClip(this.paginaQuiz.getChildByName("opcaoD")).getChildByName("alternativaText"));
			textoAlinhadoA.y = (MovieClip(this.paginaQuiz.getChildByName("opcaoA")).getChildByName("letraDaOpcao")).y // + textoAlinhadoA.textHeight;
			textoAlinhadoB.y = (MovieClip(this.paginaQuiz.getChildByName("opcaoB")).getChildByName("letraDaOpcao")).y //+ textoAlinhadoB.textHeight;
			textoAlinhadoC.y = (MovieClip(this.paginaQuiz.getChildByName("opcaoC")).getChildByName("letraDaOpcao")).y // + textoAlinhadoC.textHeight;
			textoAlinhadoD.y = (MovieClip(this.paginaQuiz.getChildByName("opcaoD")).getChildByName("letraDaOpcao")).y // + textoAlinhadoD.textHeight;
			
			MovieClip(MovieClip(this.paginaQuiz.getChildByName("opcaoA")).getChildByName("letraDaOpcao")).gotoAndStop("A");
			MovieClip(MovieClip(this.paginaQuiz.getChildByName("opcaoB")).getChildByName("letraDaOpcao")).gotoAndStop("B");
			MovieClip(MovieClip(this.paginaQuiz.getChildByName("opcaoC")).getChildByName("letraDaOpcao")).gotoAndStop("C");
			MovieClip(MovieClip(this.paginaQuiz.getChildByName("opcaoD")).getChildByName("letraDaOpcao")).gotoAndStop("D");
			
			MovieClip(paginaQuiz.getChildByName("btNext")).buttonMode = false;
			MovieClip(paginaQuiz.getChildByName("btNext")).removeEventListener(MouseEvent.CLICK, addPerguntasEAlternativas);
			var feedBack:MovieClip = MovieClip(paginaQuiz.getChildByName("timerEResposta"));
			timerTempo = 30;
			if (feedBack.currentFrameLabel != "timer")
			{
				TextField(feedBack.getChildByName("resultadoText")).text = "";
				feedBack.gotoAndStop("timer");
			}
			feedBack.timerTxt.text = "00:" + timerTempo;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, goTimer);
			//timer.start();
			
			feedBack.alpha = 0;
			TweenLite.to(feedBack, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 1.75, onComplete: ativarTimer});
		}
		
		private function ativarTimer():void
		{
			timer.start();
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).buttonMode = true;
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).mouseChildren = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).buttonMode = true;
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).mouseChildren = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).buttonMode = true;
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).mouseChildren = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).buttonMode = true;
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).mouseChildren = false;
			
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).addEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).addEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).addEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).addEventListener(MouseEvent.CLICK, verificaResposta);
			
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).addEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).addEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).addEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).addEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).addEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).addEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).addEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).addEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
		}
		
		private function goTimer(e:TimerEvent):void
		{
			var feedBack:MovieClip = MovieClip(paginaQuiz.getChildByName("timerEResposta"));
			if (timerTempo < 10)
			{
				feedBack.timerTxt.text = "00:0" + timerTempo;
			}
			else
			{
				feedBack.timerTxt.text = "00:" + timerTempo;
			}
			if (timerTempo <= 0)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, goTimer);
				verificaResposta(null);
			}
			timerTempo--;
		}
		
		private function verificaResposta(e:MouseEvent = null):void
		{
			alternativaEscolhida = true;
			removeEventos();
			var feedback:MovieClip = MovieClip(paginaQuiz.getChildByName("timerEResposta"));
			feedback.gotoAndStop("resultado");
			var respostaCerta:String = String(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getOpcaoCerta()).toUpperCase();
			var acertouResposta:Boolean = false;
			//trace("RespostaCerta:", respostaCerta);
			if (e != null)
			{
				var respostaEscolhida:String = MovieClip(e.currentTarget.getChildByName("letraDaOpcao")).currentFrameLabel;
				//trace("RespostaEscolhida:", respostaEscolhida);
				for (var i:uint = 0; i < arrayDeOpcoes.length; i++)
				{
					if (e.currentTarget.name == arrayDeOpcoes[i].name)
					{
						arrayDeOpcoes[i].getChildByName("checkBox").gotoAndStop("on");
					}
					else
					{
						arrayDeOpcoes[i].getChildByName("checkBox").gotoAndStop("off");
					}
				}
				if (respostaCerta == respostaEscolhida)
				{
					acertouResposta = true;
					cidadeEscolhida.addToPontuacao(cidadeEscolhida.arrayDeQuestionarios[cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1].getValor());
					//trace("CTD: Indice da pergunta no Array:", (cidadeEscolhida.arrayDePosicoesPerguntas[perguntasRespondidas] - 1));
					//trace("CTD: Pontos:", cidadeEscolhida.getPontuacaoFinal(), "Total:", cidadeEscolhida.getCidadePontuacaoTotal());
					TextField(feedback.getChildByName("resultadoText")).text = "Parabéns! Você acertou!";
				}
				else
				{
					TextField(feedback.getChildByName("resultadoText")).text = "A resposta certa é " + respostaCerta;
				}
			}
			else
			{
				//trace("Acabou por tempo!");
				TextField(feedback.getChildByName("resultadoText")).text = "Tempo esgotado. A resposta certa é " + respostaCerta;
			}
			if (perguntasRespondidas < (cidadeEscolhida.arrayDeQuestionarios.length - 1)) //NUMERO DE PERGUNTAS
			{
				perguntasRespondidas++;
				//trace("PerguntasRespondidas:", perguntasRespondidas, "Total:", cidadeEscolhida.arrayDeQuestionarios.length);
				paginaQuiz.getChildByName("btNext").alpha = 1;
				MovieClip(paginaQuiz.getChildByName("btNext")).buttonMode = true;
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.CLICK, addPerguntasEAlternativas);
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			}
			else
			{
				if (acertouResposta)
				{
					TextField(feedback.getChildByName("resultadoText")).text = "Parabéns! Você acertou! Ver Resultado";
				}
				else
				{
					TextField(feedback.getChildByName("resultadoText")).text = "A resposta certa é " + respostaCerta + "! Ver Resultados";
				}
				for (var j:int = 0; j < arrayDeCidades.length; j++)
				{
					if (arrayDeCidades[j].cidadeNome == cidadeEscolhida.cidadeNome)
					{
						arrayDeCidades[j].setFoiRespondida(true);
					}
				}
				if (!main.userErrado)
				{
					main.falarComServer.addPontuacaoFinalDaCidade(main.facebookUser_Id, cidadeEscolhida.getOrdem(), int(cidadeEscolhida.getPontuacaoFinal()));
				}
				paginaQuiz.getChildByName("btNext").alpha = 1;
				MovieClip(paginaQuiz.getChildByName("btNext")).buttonMode = true;
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.CLICK, goToResults);
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
				MovieClip(paginaQuiz.getChildByName("btNext")).addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			}
		}
		
		private function removeEventos():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, goTimer);
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).removeEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).removeEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).removeEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).removeEventListener(MouseEvent.CLICK, verificaResposta);
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).buttonMode = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).buttonMode = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).buttonMode = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).buttonMode = false;
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).removeEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoA")).removeEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).removeEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoB")).removeEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).removeEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoC")).removeEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).removeEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
			MovieClip(this.paginaQuiz.getChildByName("opcaoD")).removeEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
		}
		
		private function exibirCidadesSelecionaveis():void
		{
			var qtdDeColunas:int = 3;
			var qtdDeLinhas:int = 9;
			var itemNumber:int = 0;
			arrayDeBotoes = new Array();
			arrayDeCidadesSelecionaveis = new Array();
			for (var coluna:int = 0; coluna < qtdDeColunas; coluna++)
			{
				arrayDeBotoes[coluna] = new Array();
				for (var linha:int = 0; linha < qtdDeLinhas; linha++)
				{
					var btCidade:CidadeHolder = new CidadeHolder;
					btCidade.y = 210 + (30 * linha);
					btCidade.x = 35 + (230 * coluna);
					btCidade.alpha = 0;
					btCidade.name = String(arrayDeCidades[itemNumber].cidadeNome);
					btCidade.cidadeName.text = String(arrayDeCidades[itemNumber].cidadeNome).toUpperCase();
					TweenLite.to(btCidade, 0.5, {alpha: 1, ease: Cubic.easeOut, delay: 0.1 * linha});
					arrayDeBotoes[coluna][linha] = btCidade;
					if (!arrayDeCidades[itemNumber].getFoiRespondida())
					{
						btCidade.addEventListener(MouseEvent.CLICK, onCidadeSelected);
						btCidade.addEventListener(MouseEvent.MOUSE_OVER, onOverCidade);
						btCidade.addEventListener(MouseEvent.MOUSE_OUT, onOutCidade);
						btCidade.respondida = false;
					}
					else
					{
						btCidade.addEventListener(MouseEvent.CLICK, goToResultsDirectly);
						btCidade.checkBox.gotoAndStop("respondida");
						btCidade.buttonMode = false;
						btCidade.respondida = true;
					}
					btCidade.buttonMode = true;
					btCidade.selected = false;
					btCidade.mouseChildren = false;
					arrayDeCidadesSelecionaveis.push(arrayDeBotoes[coluna][linha]);
					paginaSelection.addChild(arrayDeBotoes[coluna][linha]);
					itemNumber++;
				}
					//trace("ArrayDeBotoes[0].length:", arrayDeBotoes[0].length);
					//trace ("ArrayDeBotoes[1]:", arrayDeBotoes[1].length);
					//trace ("ArrayDeBotoes[2]:", arrayDeBotoes[2].length);
			}
		}
		
		private function onOverCidade(e:MouseEvent):void
		{
			if (!e.currentTarget.selected)
			{
				if (!alternativaEscolhida)
				{
					e.currentTarget.checkBox.gotoAndStop("over");
				}
			}
		}
		
		private function onOutCidade(e:MouseEvent):void
		{
			if (!e.currentTarget.selected)
			{
				if (!alternativaEscolhida)
				{
					e.currentTarget.checkBox.gotoAndStop("off");
				}
			}
		}
		
		private function getCidadeByName(name:String):Cidade
		{
			for (var i:int = 0; i < arrayDeCidades.length; i++)
			{
				if (arrayDeCidades[i].cidadeNome == name)
				{
					return arrayDeCidades[i];
				}
			}
			return null;
		}
		
		private function goToResultsDirectly(e:MouseEvent):void
		{
			trace("[Controlador] - goToResultsDirectly");
			
			for (var i:int = 0; i < arrayDeCidadesSelecionaveis.length; i++)
			{
				if (e.currentTarget.name == arrayDeCidadesSelecionaveis[i].name)
				{
					arrayDeCidadesSelecionaveis[i].selected = true;
					cidadeEscolhida = getCidadeByName(e.currentTarget.name);
				}
				else
				{
					if (arrayDeCidadesSelecionaveis[i].respondida == false)
					{
						arrayDeCidadesSelecionaveis[i].checkBox.gotoAndStop("off");
					}
					arrayDeCidadesSelecionaveis[i].selected = false;
				}
			}
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).visible = true;
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).gotoAndStop("verResultados");
			TweenLite.to(MovieClip(paginaSelection.getChildByName("cidadeSelecionada")), 0.25, {alpha: 1, ease: Cubic.easeOut});
			
			MovieClip(paginaSelection.getChildByName("btNext")).alpha = 1;
			MovieClip(paginaSelection.getChildByName("btNext")).buttonMode = true;
			
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.CLICK, goToQuiz);
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.CLICK, goToResults);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
		}
		
		private function onCidadeSelected(e:MouseEvent):void
		{
			for (var i:int = 0; i < arrayDeCidadesSelecionaveis.length; i++)
			{
				if (e.currentTarget.name == arrayDeCidadesSelecionaveis[i].name)
				{
					arrayDeCidadesSelecionaveis[i].checkBox.gotoAndStop("on");
					arrayDeCidadesSelecionaveis[i].selected = true;
					cidadeEscolhida = getCidadeByName(e.currentTarget.name);
				}
				else
				{
					if (arrayDeCidadesSelecionaveis[i].respondida == false)
					{
						arrayDeCidadesSelecionaveis[i].checkBox.gotoAndStop("off");
					}
					arrayDeCidadesSelecionaveis[i].selected = false;
				}
			}
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).visible = true;
			MovieClip(paginaSelection.getChildByName("cidadeSelecionada")).gotoAndStop("escolhi");
			TweenLite.to(MovieClip(paginaSelection.getChildByName("cidadeSelecionada")), 0.25, {alpha: 1, ease: Cubic.easeOut});
			
			MovieClip(paginaSelection.getChildByName("btNext")).alpha = 1;
			MovieClip(paginaSelection.getChildByName("btNext")).buttonMode = true;
			
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.CLICK, goToResults);
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaSelection.getChildByName("btNext").removeEventListener(MouseEvent.MOUSE_OUT, overAndOut);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.CLICK, goToQuiz);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.MOUSE_OVER, overAndOut);
			paginaSelection.getChildByName("btNext").addEventListener(MouseEvent.MOUSE_OUT, overAndOut);
		}
		
		private function overAndOut(e:MouseEvent):void
		{
			//trace("[ControladorDeTelas] - overAndOut:", e.type, " on ", e.currentTarget.name);
			if (e.type == MouseEvent.MOUSE_OUT)
			{
				TweenLite.to(e.currentTarget, 0.25, {scaleX: 1, scaleY: 1, ease: Back.easeOut});
			}
			else if (e.type == MouseEvent.MOUSE_OVER)
			{
				TweenLite.to(e.currentTarget, 0.25, {scaleX: 1.1, scaleY: 1.1, ease: Back.easeOut});
			}
		}
	}
}