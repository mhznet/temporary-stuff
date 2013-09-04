package entities
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.ui.Keyboard;
	
	import ash.core.Engine;
	import ash.core.Entity;
	
	import comp.Comp_Display;
	import comp.Comp_NPC;
	import comp.Comp_PlayerControl;
	import comp.Comp_PlayerFlipper;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public final class EntityCreator
	{
		[Embed(source="../assets/character_atlas.xml", mimeType="application/octet-stream")]
		public const Game_Atlas_XML:Class;
		[Embed(source="../assets/asset_atlas.png")]
		public const Game_Atlas_PNG:Class;
		private var engine:Engine;
		private var player:Entity;
		private var npcVector:Vector.<Entity>;
		private var atlas :TextureAtlas;
		public function EntityCreator(ashEngine:Engine)
		{
			engine = ashEngine;
			createAtlas();
			createAshEntities();
		}
		private function createAtlas():void
		{
			var texture:Texture = Texture.fromBitmap(new Game_Atlas_PNG());
			var xml:XML = XML(new Game_Atlas_XML());
			atlas = new TextureAtlas(texture, xml);
		}
		private function createAshEntities():void
		{
			createPlayer();
			createNPCs();
			createHoles();
		}
		private function createPlayer():void
		{
			var textureVector:Vector.<Texture> = new Vector.<Texture>();
			textureVector.push(atlas.getTexture(GameConstants.ATLAS_WALK1));
			textureVector.push(atlas.getTexture(GameConstants.ATLAS_WALK2));
			var movieClip:MovieClip = new MovieClip(textureVector);
			player = new Entity(GameConstants.LUIGI);
			player.add(new Comp_Position(0,0));
			player.add(new Comp_Speed(10,0));
			player.add(new Comp_PlayerControl(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
			player.add(new Comp_Display(movieClip));
			player.add(new Comp_PlayerFlipper());
			engine.addEntity(player);
		}
		private function createNPCs():void
		{
			npcVector = new Vector.<Entity>();
			for (var i:int = 1; i <= GameConstants.NPC_NUMBER; i++) 
			{
				var texturVctr:Vector.<Texture> = new Vector.<Texture>();
				texturVctr.push(atlas.getTexture(GameConstants.ATLAS_WALK1));
				texturVctr.push(atlas.getTexture(GameConstants.ATLAS_WALK2));
				var mc:MovieClip = new MovieClip(texturVctr,12);
				var entity:Entity = new Entity(i.toString());
				entity.add(new Comp_Position(0,60*i));
				entity.add(new Comp_Speed(Math.ceil(Math.random()*4),0));
				entity.add(new Comp_Display(mc));
				entity.add(new Comp_NPC());
				engine.addEntity(entity);
				npcVector.push(entity);
			}
		}
		private function createHoles():void
		{
			
		}
	}
}