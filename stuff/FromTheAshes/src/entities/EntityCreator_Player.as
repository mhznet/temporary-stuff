package entities
{
	import flash.ui.Keyboard;
	
	import ash.core.Engine;
	import ash.core.Entity;
	
	import comp.Comp_Collision;
	import comp.Comp_Damage;
	import comp.Comp_Display;
	import comp.Comp_Health;
	import comp.entity.Comp_Player;
	import comp.Comp_PlayerFlipper;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public final class EntityCreator_Player
	{
		private var engine:Engine;
		private var atlas:TextureAtlas;
		private var player:Entity;
		public function EntityCreator_Player(ashEngine:Engine, atlasValue:TextureAtlas)
		{
			engine = ashEngine;
			atlas = atlasValue;
			createPlayer();
		}
		private function createPlayer():void
		{
			var textureVector:Vector.<Texture> = new Vector.<Texture>();
			textureVector.push(atlas.getTexture(GameConstants.ATLAS_WALK1));
			textureVector.push(atlas.getTexture(GameConstants.ATLAS_WALK2));
			var movieClip:MovieClip = new MovieClip(textureVector);
			player = new Entity(GameConstants.LUIGI);
			player.add(new Comp_Display(movieClip));
			player.add(new Comp_Player(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
			player.add(new Comp_PlayerFlipper());
			player.add(new Comp_Collision());
			player.add(new Comp_Speed(10,0));
			player.add(new Comp_Position(0,0));
			engine.addEntity(player);
		}
		public function destroy():void{}
	}
}