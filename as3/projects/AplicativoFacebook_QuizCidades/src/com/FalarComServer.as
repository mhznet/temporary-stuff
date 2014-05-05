package com
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import com.adobe.serialization.json.JSON
	import flash.system.LoaderContext;
	import flash.system.Security;
	import com.ControladorDeTelas;
	import com.Main;
	import fl.controls.TextArea;
	
	public class FalarComServer
	{
		private const url_getAllAverages				:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_getGeneralAverage.php"; // MEDIA GERAL CONJUNTA
		private const url_getAllAverageByUser		:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_getGeneralAverageByDistinctUser.php"; // MEDIA GERAL POR USUARIOS UNICOS
		private const url_getPoints					:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_consulta_pontuacao.php"; // MEUS PONTOS E CIDADES QUE RESPONDI
		private const url_getAverageByCity			:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_getAverageResultByCities.php"; // RETORNA MEDIA INDIVIDUAL POR CIDADE 
		private const url_addUser						:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_register_user.php"; // ADD USER
		private const url_addPointsByCity				:String = "http://facebook.revistaglamour.globo.com/conhecidade/php/epoca_set_player_points.php" // ADD POINTS POR CIDADE
		
/*		private const url_getAllAverages				:String = "http://107.20.243.238/epocaQuizCidades/epoca_getGeneralAverage.php"; // MEDIA GERAL CONJUNTA
		private const url_getAllAverageByUser		:String = "http://107.20.243.238/epocaQuizCidades/epoca_getGeneralAverageByDistinctUser.php"; // MEDIA GERAL POR USUARIOS UNICOS
		private const url_getPoints					:String = "http://107.20.243.238/epocaQuizCidades/epoca_consulta_pontuacao.php"; // MEUS PONTOS E CIDADES QUE RESPONDI
		private const url_getAverageByCity			:String = "http://107.20.243.238/epocaQuizCidades/epoca_getAverageResultByCIty.php"; // RETORNA MEDIA INDIVIDUAL POR CIDADE 
		private const url_addUser						:String = "http://107.20.243.238/epocaQuizCidades/epoca_register_user.php"; // ADD USER
		private const url_addPointsByCity				:String = "http://107.20.243.238/epocaQuizCidades/epoca_set_player_points.php" // ADD POINTS POR CIDADE*/
		
		private var main:Main;
		private const SERVER:String = "[FalarComServer] - ";
		private var situacaoJogador:String = "";
		private const USUARIO_JA_EXISTE:String = "USUARIO_JA_EXISTE";
		private const USUARIO_NOVO:String = "USUARIO_NOVO";
		private const OK:String = "OK";
		private const NOK:String = "NOK";
		//private var outputTxt:TextArea;
		public var verifica_UsuarioAdicionado:Boolean = false;
		public var verifica_MediaGeralPega:Boolean = false;
		public var verifica_MediaCidadesPegas:Boolean = false;
		public var verifica_PontuacaoJogadorPega:Boolean = false;
		public var eventosLiberadosNaAbout:Boolean = false;
		public var liberaProgresso:Boolean = false;
		
		public function FalarComServer(pai:Main):void
		{
			trace(SERVER + "New()!");
			main = pai;
			//this.outputTxt = TextArea(main.controladorDeTelas.outputText);
		}
		
		private function liberaEventosDaPaginaAbout():void
		{
			trace(SERVER + "liberaEventosDaPaginaAbout:\n", "UserAdded:", verifica_UsuarioAdicionado, "\n MediaGeral:", verifica_MediaGeralPega, "\n MediasIndividuais:", verifica_MediaCidadesPegas, "\n PontuacaoJogadorPega:", verifica_PontuacaoJogadorPega);
			if (situacaoJogador != USUARIO_JA_EXISTE)
			{
				verifica_PontuacaoJogadorPega = true;
			}
			if (liberaProgresso || main.userErrado)
			{
				verifica_PontuacaoJogadorPega = true;
				verifica_UsuarioAdicionado = true;
				verifica_MediaGeralPega = true;
				verifica_MediaCidadesPegas = true;
			}
			if (verifica_UsuarioAdicionado && verifica_MediaGeralPega && verifica_MediaCidadesPegas && verifica_PontuacaoJogadorPega)
			{
				if (!eventosLiberadosNaAbout)
				{
					if (main.controladorDeTelas.paginaAbout != null)
					{
						main.controladorDeTelas.addEventosDaPaginaAbout();
						eventosLiberadosNaAbout = true;
					}
					else
					{
						main.controladorDeTelas.liberaAddEventosNaAbout = true;
					}
				}
				else{}
			}
			else{}
		}
		
		public function atualizarDados():void
		{
			trace(SERVER + "atualizarDados()");
			this.getGeneralAverage();
			this.getCityAverages();
		}
		
		/***Adiciona o user ao server e seu callbakc**/
		public function addUsuario(facebookUser_Id:int, facebookUser_Name:String, facebookUser_Date:String, facebookUser_City:String, facebookUser_Sex:String):void //callBackUserAdded
		{
			//outputTxt.appendText("\n@@@@@@" + "Adicionando no banco");
			trace(SERVER + "addUsuario()");
			var phpVars:URLVariables = new URLVariables();
			phpVars.faceBookID = facebookUser_Id;
			phpVars.name = facebookUser_Name;
			phpVars.date = facebookUser_Date;
			phpVars.city = facebookUser_City;
			phpVars.sex = facebookUser_Sex;
			
			var urlRequest:URLRequest = new URLRequest(url_addUser);
			
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = phpVars;
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, callBack_AddUsuario);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false,0, true);
			urlLoader.load(urlRequest);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			trace (SERVER + "securityErrorHandler()", e.errorID, e);
			main.userErrado = true;
			liberaEventosDaPaginaAbout();
		}
		
		public function callBack_AddUsuario(e:Event):void
		{
			var loader:URLLoader = URLLoader(e.target);
			//outputTxt.appendText("\ncallBackUserAdded - loader.data" + loader.data);
			trace ("loader.data", loader.data);
			var jsonArray:Array = JSON.decode(loader.data);
			var respostaServer:String = jsonArray[0].status.RESPONSE;
			trace(SERVER + "callBack_AddUsuario", respostaServer);
			situacaoJogador = respostaServer;
			verifica_UsuarioAdicionado = true;
			this.getGeneralAverage();
			this.getCityAverages();
			if (respostaServer == USUARIO_JA_EXISTE)
			{
				//getCidades respondidas e pontuacao do jogador
				this.getPontuacaoFinalDasCidades(main.facebookUser_Id);
			}
			else
			{
				//main.controladorDeTelas.addEventosDaPaginaAbout();
			}
			liberaEventosDaPaginaAbout();
		}
		
		/**ADD OS PONTOS DA CIDADE FEITOS PELO PLAYA**/
		public function addPontuacaoFinalDaCidade(_faceBookID:int, _cityID:int, _points:int):void
		{
			trace(SERVER + "addPontuacaoFinalDaCidade()");
			var phpVars:URLVariables = new URLVariables();
			phpVars.faceBookID = _faceBookID;
			phpVars.cityID = _cityID;
			phpVars.points = _points;
			
			var loader:URLLoader = new URLLoader();
			
			var urlRequest:URLRequest = new URLRequest(url_addPointsByCity);
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = phpVars;
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false,0, true);
			loader.addEventListener(Event.COMPLETE, callBack_addPontuacaoFinalDaCidade, false, 0, true);
			loader.load(urlRequest);
		}
		
		private function callBack_addPontuacaoFinalDaCidade(e:Event):void
		{
			atualizarDados();
			trace(SERVER + "callBack_addPontuacaoFinalDaCidade()");
			var loader:URLLoader = URLLoader(e.target);
			trace ("loader.data", loader.data);
			var jsonArray:Array;
			if (loader.data != null)
			{
				jsonArray = JSON.decode(loader.data);
				trace(SERVER + "Pontuacao Adicionada:", jsonArray[0].status.RESPONSE);
			}
			else
			{
				trace(SERVER + "Pontuacao Adicionada:", loader.data);
			}
		}
		
		/**PEGA PONTOS DO JOGADOR E CIDADES JOGADAS POR ELE**/
		public function getPontuacaoFinalDasCidades(playerId:int):void
		{
			trace(SERVER + "getPontuacaoFinalDasCidades()");
			var phpVars:URLVariables = new URLVariables();
			phpVars.faceBookID = playerId;
			
			var loader:URLLoader = new URLLoader();
			
			var urlRequest:URLRequest = new URLRequest(url_getPoints);
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = phpVars;
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false,0, true);
			loader.addEventListener(Event.COMPLETE, callBack_GetPontuacaoFinalDasCidades, false, 0, true);
			loader.load(urlRequest);
		}
		
		public function callBack_GetPontuacaoFinalDasCidades(e:Event):void
		{
			//TODO salvar pontos do jogador e das cidades jogadas no controlador e libera eventos pra prosseguir
			trace(SERVER + "callBack_GetPontuacaoFinalDasCidades()");
			var loader:URLLoader = URLLoader(e.target);
			var jsonArray:Array;
			if (loader.data != null)
			{
				trace("loader.data: " + loader.data);
				jsonArray = JSON.decode(loader.data);
			}
			if (jsonArray != null)
			{
				for each (var dados:Object in jsonArray)
				{
					if (dados.city != null)
					{
						var cidade:Cidade = main.getCidadeById(dados.city);
						if (cidade != null)
						{
							cidade.setFoiRespondida(true);
							cidade.setPontuacaoFinal(dados.points);
							trace("Setado", dados.points, "pontos na cidade de id", dados.city, cidade.cidadeNome);
						}
						else
						{
							trace("Cidade recebida é nula, logo não consigo setar pontos nela");
						}
					}
				}
			}
			else
			{
				liberaProgresso = true;
			}
			verifica_PontuacaoJogadorPega = true;
			//main.controladorDeTelas.addEventosDaPaginaAbout();
			liberaEventosDaPaginaAbout();
		}
		
		/**PEGA A MEDIA POR CIDADE**/
		public function getCityAverages():void
		{
			//TODO como enviar
			trace(SERVER + "getCityAverages()");
			var loader:URLLoader = new URLLoader();
			var resque:URLRequest = new URLRequest(url_getAverageByCity);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false,0, true);
			loader.addEventListener(Event.COMPLETE, callBack_GetCityAverages, false, 0, true);
			loader.load(resque);
		}
		
		public function callBack_GetCityAverages(e:Event):void
		{
			//TODO salvar as medias da cidades
			trace(SERVER + "callBack_GetCityAverages()");
			
			var loader:URLLoader = URLLoader(e.target);
			trace (loader.data);
			var jsonArray:Array;
			if (loader.data != null)
			{
				jsonArray = JSON.decode(loader.data);
			}
			if (jsonArray != null)
			{
				//trace("loader.data: " + loader.data);
				trace(SERVER + "Numero de Cidades com PontuacaoMedia:", jsonArray.length);
				for each (var dados:Object in jsonArray)
				{
					var cidade:Cidade = main.getCidadeById(dados.id);
					if (cidade != null)
					{
						cidade.setPontuacaoMedia(dados.average);
					}
					else
					{
						trace("Cidade é nula não consigo setar pontuacaoMEdia nela");
					}
				}
				verifica_MediaCidadesPegas = true;
				liberaEventosDaPaginaAbout();
			}
			else
			{
				liberaProgresso = true;
			}
			verifica_MediaCidadesPegas = true;
			liberaEventosDaPaginaAbout();
		}
		
		/**media geral de todas cidades juntas e seu callback**/
		public function getGeneralAverage():void
		{
			trace(SERVER + "getGeneralAverage()");
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(url_getAllAverages);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false,0, true);
			loader.addEventListener(Event.COMPLETE, callBack_GetGeneralAverage, false, 0, true);
			loader.load(request);
		}
		
		public function callBack_GetGeneralAverage(e:Event):void
		{
			trace(SERVER + "callBack_GetGeneralAverage");
			var loader:URLLoader = URLLoader(e.target);
			var jsonArray:Array = JSON.decode(loader.data);
			var mediaTodasCidades:Number = jsonArray[0].average.average;
			//trace("MediaGeralDeTodasAsCidadesJuntas:",mediaTodasCidades);
			main.setPontuacaoMediaTodasCidades(mediaTodasCidades);
			verifica_MediaGeralPega = true;
			liberaEventosDaPaginaAbout();
		}
		
		/****/
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			trace(SERVER + "IOError carregando:", e.text);
		}
	}
}