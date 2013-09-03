package net.richardlord.asteroids
{
	import flash.ui.Keyboard;
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;
	import net.richardlord.asteroids.components.Asteroid;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Display3D;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Spaceship;
	import net.richardlord.asteroids.components.StarlingDisplay;
	import net.richardlord.asteroids.graphics.AsteroidView;
	import net.richardlord.asteroids.graphics.BulletView;
	import net.richardlord.asteroids.graphics.DummyCylinder;
	import net.richardlord.asteroids.graphics.DummyQuad;
	import net.richardlord.asteroids.graphics.DummySphere;
	import net.richardlord.asteroids.graphics.SpaceshipView;
	import net.richardlord.asteroids.graphics.StarlingAssetFactory;
	import net.richardlord.asteroids.GameConfig;
	

	public class EntityCreator
	{
		private var game : Game;
		private var gameConfig : GameConfig;
		private var _starlingAssetFactory:StarlingAssetFactory;
		
		public function EntityCreator( gameConfig:GameConfig, game : Game )
		{
			this.game = game;
			this.gameConfig = gameConfig;
		}
		
		public function destroyEntity( entity : Entity ) : void
		{
			game.removeEntity( entity );
		}
		
		public function createGame() : Entity
		{
			// init Starling asset generator
			if (gameConfig.renderMode == GameConfig.RENDER_MODE_STARLING)
			{
				_starlingAssetFactory = new StarlingAssetFactory(true);
			}
			
			var gameEntity : Entity = new Entity()
				.add( new GameState() );
			game.addEntity( gameEntity );
			return gameEntity;
		}

		public function createAsteroid( radius : Number, x : Number, y : Number ) : Entity
		{
			var asteroid : Entity = new Entity()
				.add( new Asteroid() )
				.add( new Position( x, y, 0, radius ) )
				.add( new Motion( ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), Math.random() * 2 - 1, 0 ) );
				
			switch (gameConfig.renderMode)
			{
			case GameConfig.RENDER_MODE_STARLING:
				asteroid.add(_starlingAssetFactory.createAsteroid(radius));
				break;
				
			case GameConfig.RENDER_MODE_AWAY3D:
				asteroid.add(new Display3D(new DummySphere(radius)));
				break;
				
			case GameConfig.RENDER_MODE_DISPLAY_LIST:
			default:
				asteroid.add(new Display(new AsteroidView(radius)));
				break;
			}
			game.addEntity( asteroid );
			return asteroid;
		}

		public function createSpaceship() : Entity
		{
			var spaceship : Entity = new Entity()
				.add( new Spaceship() )
				.add( new Position( gameConfig.width / 2, gameConfig.height / 2, 0, 6 ) )
				.add( new Motion( 0, 0, 0, 15 ) )
				.add( new Gun( 8, 0, 0.3, 2 ) )
				.add( new GunControls( Keyboard.Z ) );
			
			// check render mode
			var invertControl:Boolean = false;
			switch (gameConfig.renderMode)
			{
			case GameConfig.RENDER_MODE_STARLING:
				spaceship.add(_starlingAssetFactory.createSpaceship());
				break;
				
			case GameConfig.RENDER_MODE_AWAY3D:
				spaceship.add(new Display3D(new DummyCylinder(20)));
				invertControl = true;
				break;
				
			case GameConfig.RENDER_MODE_DISPLAY_LIST:
			default:
				spaceship.add(new Display(new SpaceshipView()));
				break;
			}
			
			// controls need to be inverted on away3D
			spaceship .add(new MotionControls(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, 100, 3, invertControl));
			
			game.addEntity( spaceship );
			return spaceship;
		}

		public function createUserBullet( gun : Gun, parentPosition : Position ) : Entity
		{
			var cos : Number = Math.cos( parentPosition.rotation );
			var sin : Number = Math.sin( parentPosition.rotation );
			var bullet : Entity = new Entity()
				.add( new Bullet( gun.bulletLifetime ) )
				.add( new Position(
					cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x,
					sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y,
					parentPosition.rotation, 0 ) )
				.add( new Motion( cos * 150, sin * 150, 0, 0 ) );
				
			switch (gameConfig.renderMode)
			{
			case GameConfig.RENDER_MODE_STARLING:
				bullet.add(_starlingAssetFactory.createUserBullet());
				break;
				
			case GameConfig.RENDER_MODE_AWAY3D:
				bullet.add(new Display3D(new DummySphere(2)));
				break;
				
			case GameConfig.RENDER_MODE_DISPLAY_LIST:
			default:
				bullet.add(new Display(new BulletView()));
				break;
			}
				
			game.addEntity( bullet );
			return bullet;
		}
	}
}
