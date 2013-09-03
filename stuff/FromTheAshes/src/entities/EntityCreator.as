package entities
{
	import flash.display.DisplayObject;
	import flash.ui.Keyboard;
	
	import ash.core.Engine;
	import ash.core.Entity;
	
	import comp.Comp_Display;
	import comp.Comp_NPC;
	import comp.Comp_PlayerControl;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public final class EntityCreator
	{
		[Embed(source="character_atlas.xml", mimeType="application/octet-stream")]
		public const AtlasXml:Class;
		[Embed(source="../assets/asset_atlas.png")]
		public const AtlasTexture:Class;
		/*[Embed(source="../assets/asset.png")]
		private const Luigi:Class;*/
		private var engine:Engine;
		private var player:Entity;
		private var atlas :TextureAtlas;
		public function EntityCreator(ashEngine:Engine)
		{
			engine = ashEngine;
			createAtlas();
			createAshEntities();
		}
		
		private function createAtlas():void
		{
			var texture:Texture = Texture.fromBitmap(new AtlasTexture());
			var xml:XML = XML(new AtlasXml());
			atlas = new TextureAtlas(texture, xml);
			// display a sub-texture
			var moonTexture:Texture = atlas.getTexture("moon");
			var moonImage:Image = new Image(moonTexture);			
		}
		private function createAshEntities():void
		{
			player = new Entity(GameConstants.LUIGI);
			player.add(new Comp_Position(0,0));
			player.add(new Comp_Speed(10,0));
			player.add(new Comp_PlayerControl(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
			player.add(new Comp_Display(atlas.getTexture(GameConstants.ATLAS_STILL) as DisplayObject));
			engine.addEntity(player);
			
			for (var i:int = 1; i <= GameConstants.NPC_NUMBER; i++) 
			{
				var entity:Entity = new Entity(i.toString());
				entity.add(new Comp_Position(0,60*i));
				entity.add(new Comp_Speed(Math.ceil(Math.random()*4),0));
				entity.add(new Comp_Display(atlas.getTexture(GameConstants.ATLAS_STILL) as DisplayObject));
				entity.add(new Comp_NPC());
				engine.addEntity(entity);
			}
		}
	}
}