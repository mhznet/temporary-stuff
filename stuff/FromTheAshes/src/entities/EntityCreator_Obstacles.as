package entities
{
	import ash.core.Engine;
	import ash.core.Entity;
	
	import comp.Comp_Collision;
	import comp.Comp_Display;
	import comp.Comp_Damage;
	import comp.Comp_Health;
	import comp.entity.Comp_Obstacle;
	import comp.Comp_Position;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EntityCreator_Obstacles
	{
		private var engine:Engine;
		private var atlas:TextureAtlas;
		
		public function EntityCreator_Obstacles(ashEngine:Engine, atlasValue:TextureAtlas)
		{
			engine = ashEngine;
			atlas = atlasValue;
			createObstacle();
		}
		private function createObstacle():void
		{
				var textureVector:Vector.<Texture> = new Vector.<Texture>();
				textureVector.push(atlas.getTexture(GameConstants.ATLAS_DOWN));
				var movieClip:MovieClip = new MovieClip(textureVector);
				var obstacle:Entity = new Entity(GameConstants.OBSTACLE);
				obstacle.add(new Comp_Position(50,0));
				obstacle.add(new Comp_Display(movieClip));
				obstacle.add(new Comp_Obstacle());
				obstacle.add(new Comp_Collision());
				engine.addEntity(obstacle);
		}
		public function destroy():void{}
	}
}