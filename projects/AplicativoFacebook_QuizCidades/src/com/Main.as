package com
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import com.adobe.serialization.json.JSON
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	public class Main extends MovieClip
	{
		public var facebookUser_Id:int = 1411894489;
		public var facebookUser_Name:String = "Matheus Henrique Zanetti";
		public var facebookUser_Date:String = "1988-11-09";
		public var facebookUser_City:String = "Curitiba";
		public var facebookUser_Sex:String = "male";
		
		
		public var userErrado:Boolean = false;
		public var falarComServer:FalarComServer;
		public var controladorDeTelas:ControladorDeTelas = null;
		private var cidadesRequest:URLRequest;
		private var cidadesLoader:URLLoader;
		private var cidadesXML:XML
		private var cidadesURL:String = "xml/config.xml";
		private var xmlLoader:URLLoader;
		private var xmlRequest:URLRequest;
		public var totalCidades:int;
		public var teste:Boolean = false;
		public var pontuacaoMediaTodasCidades:Number = 0;
		public var arrayDePosicoesDePerguntas:Array;
		public var numCidadesLoaded:int = 0;
		public var arrayConfigCidadeId:Array;
		public var isLocal:Boolean = true;
		/**Google Analytics**/
		public var tracker				:AnalyticsTracker;
		
		public function Main():void
		{
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("http://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("http://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			trace("[Main isLocal] - ", isLocal);
			falarComServer = new FalarComServer(this);
			
			if (isLocal)
			{
				facebookUser_Id = 1411894489;
				facebookUser_Name = "Matheus Henrique Zanetti";
				facebookUser_Date = "1988-11-09";
				facebookUser_City = "Curitiba";
				facebookUser_Sex = "male";
			}
			else
			{
				facebookUser_Id = 0;
				facebookUser_Name = "";
				facebookUser_Date = "";
				facebookUser_City = "";
				facebookUser_Sex = "";
			}
			
			//---------Outros
			//falarComServer.getGeneralAverage();
			//falarComServer.getCityAverages();
			
			//----------Sua
			//falarComServer.addUserToServer(facebookUser_Id,facebookUser_Name,facebookUser_Date,facebookUser_City,facebookUser_Sex);
			//falarComServer.getPointsByPlayerId(34885038);	
			//falarComServer.addPointsByCity(facebookUser_Id, 1, 1);
			this.iniciar();
		}
		
		private function iniciar():void
		{
			trace("[Main] - init()");
			if (!isLocal)
			{
				iniciarGA();
			}
			addCreditos();
			loadCidadesXML();
			addControladorDeTelas();
		}
		
		public function iniciarGA():void{
			try {
				trace ("[Main] - iniciarGA")
				//this.tracker = new GATracker(this, "UA-3320871-1", "AS3", false);
				//this.tracker.trackPageview("/conhecidade/paginaCarregandoApp");
			}catch(e:Error){
				throw new Error("O Flash não conseguiu iniciar o Google Analytics");
			}finally{
				
			}
		}
		
		private function addCreditos():void
		{
			var myMenu:ContextMenu = new ContextMenu();
			var creditos:ContextMenuItem = new ContextMenuItem("Redação Época - Conhecidade",false,false);
			var desenvolvimento:ContextMenuItem = new ContextMenuItem("Equipe de Programação:",true,false);
			var cheny:ContextMenuItem = new ContextMenuItem("- Cheny Schmeling",false,false);
			var douglas:ContextMenuItem = new ContextMenuItem("- Douglas Mendes",false,false);
			var mhz:ContextMenuItem = new ContextMenuItem("- Matheus Zanetti",false,false);
			myMenu.hideBuiltInItems();
			myMenu.customItems.push(creditos,desenvolvimento,cheny,douglas,mhz);
			contextMenu = myMenu;
		}
		
		private function addControladorDeTelas():void
		{
			trace("[Main] - addControladorDeTelas");
			
			this.controladorDeTelas = new ControladorDeTelas();
			this.controladorDeTelas.iniciar(this);
			this.addChild(controladorDeTelas);
		}
		
		public function loadCidadesXML():void
		{
			trace("[Main] - loadCidadesXML");
			var date:Date = new Date();
			var numVal:int = date.time;
			if (isLocal)
			{
				cidadesRequest = new URLRequest(cidadesURL /*+ "?v=" + String(numVal)*/);
			}
			else
			{
				cidadesRequest = new URLRequest(cidadesURL + "?v=" + String(numVal));
			}
			cidadesLoader = new URLLoader();
			cidadesLoader.addEventListener(Event.COMPLETE, onCompleteCidadesXML, false, 0, true);
			cidadesLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			cidadesLoader.load(cidadesRequest);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			//trace("IOError carregando:", e.text);
		}
		
		private function onCompleteCidadesXML(e:Event):void
		{
			cidadesXML = new XML(cidadesLoader.data);
			arrayDePosicoesDePerguntas = new Array();
			totalCidades = cidadesXML.*[0].*.length();
			var totalPerguntas:int = cidadesXML.*[1].*.length();
			//trace("Carregou XML das cidades total de:", totalCidades);
			if (teste)
				totalCidades = 1;
			arrayConfigCidadeId = new Array();
			for (var i:uint = 0; i < totalCidades; i++)
			{
				var objetoConfig:Object = new Object();
				objetoConfig.cidadeNome = new String();
				objetoConfig.cidadeId = new int();
				objetoConfig.cidadeId = cidadesXML.*[0].*[i].@id;
				objetoConfig.cidadeNome = cidadesXML.*[0].*[i].@nome;
				arrayConfigCidadeId.push(objetoConfig);
				//trace ("OBJETOCONFIG:",objetoConfig.cidadeId, objetoConfig.cidadeNome);
				//trace ("onCompleteCidadesXML carregarei XML especifico da", cidadesXML.*[0].*[i].@nome);
				loadXML(cidadesXML.*[0].*[i].@url, cidadesXML.*[0].*[i].@id);
				
			}
			for (var j:int = 0; j < totalPerguntas; j++)
			{
				//trace ("ID:",cidadesXML.*[1].*[j].@id);
				arrayDePosicoesDePerguntas.push(cidadesXML.*[1].*[j].@id)
			}
		}
		
		public function loadXML(nome:String, id:int):void
		{
			//trace ("loadXML:", nome);
			//nome = "aracaju.xml";
			var date:Date = new Date();
			var numVal:int = date.time;
			if (isLocal)
			{
				xmlRequest = new URLRequest("xml/cidades/" + nome /*+"?v=" + String(numVal)*/);
			}
			else
			{
				xmlRequest = new URLRequest("xml/cidades/" + nome + "?v=" + String(numVal));
			}
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, fillCity, false, 0, true);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			xmlLoader.load(xmlRequest);
		}
		
		private function fillCity(e:Event):void
		{
			//trace ("fillCity!!!");
			numCidadesLoaded++;
			var cidadeXML:XML = new XML(e.target.data);
			var cidade:Cidade = new Cidade();
			cidade.fillQeA(cidadeXML, arrayDePosicoesDePerguntas);
			controladorDeTelas.arrayDeCidades.push(cidade);
			for (var i:int = 0; i < arrayConfigCidadeId.length; i++)
			{
				if (cidade.cidadeNome == arrayConfigCidadeId[i].cidadeNome)
				{
					cidade.setOrdem(arrayConfigCidadeId[i].cidadeId);
				}
			}
			//trace ("ArrayDeCidades", controladorDeTelas.arrayDeCidades.length, cidade.getFoiRespondida());
			//trace("numCidadesLoaded:", numCidadesLoaded , " de totalCidades:", totalCidades, cidade.cidadeNome, cidade.getOrdem());
			if (numCidadesLoaded == totalCidades)
			{
				controladorDeTelas.addEventosNaIntro();
			}
		}
		
		public function getPontuacaoMediaTodasCidades():Number
		{
			return pontuacaoMediaTodasCidades;
		}
		
		public function setPontuacaoMediaTodasCidades(value:Number):void
		{
			trace("[Main] - setPontuacaoMediaTodasCidades", value);
			pontuacaoMediaTodasCidades = value;
		}
		
		public function getCidadeById(ordem:int):Cidade
		{
			//trace("[Main] - getCidadeById", ordem);
			var arrayCidades:Array = controladorDeTelas.arrayDeCidades;
			for (var i:int = 0; i < arrayCidades.length; i++)
			{
				//trace ("Procuro ", ordem, "em", arrayCidades[i].getOrdem());
				if (ordem == arrayCidades[i].getOrdem())
				{
					return arrayCidades[i];
				}
			}
			return null;
		}
	}
}