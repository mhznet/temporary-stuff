package systems
{
	import ash.tools.ListIteratingSystem;
	
	import comp.entity.Comp_Player;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import input.KeyPoll;
	
	import nodes.Node_PlayerControl;
	
	public class System_PlayerControl extends ListIteratingSystem
	{
		private var keyPoll	:KeyPoll;
		public function System_PlayerControl(key:KeyPoll):void
		{
			this.keyPoll = key;
			super(Node_PlayerControl, nodeUpdate);
		}
		private function nodeUpdate(node:Node_PlayerControl, time:Number):void
		{
			var controlComp	:Comp_Player = node.control;
			var posComp		:Comp_Position = node.position;
			var speed		:Comp_Speed	= node.speed;
			if (keyPoll.isDown(controlComp.left))
			{
				posComp.X -= speed.X;
			}
			if (keyPoll.isDown(controlComp.right))
			{
				posComp.X += speed.X;
			}
			if (keyPoll.isDown(controlComp.up))
			{
				//Olha pra cima
			}
			if (keyPoll.isDown(controlComp.down))
			{
				//Olha pra baixo
			}
			if (keyPoll.isDown(controlComp.space_bar))
			{
				//Pula
			}
		}
	}
}