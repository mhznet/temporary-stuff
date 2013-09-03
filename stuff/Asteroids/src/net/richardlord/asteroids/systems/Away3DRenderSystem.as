package net.richardlord.asteroids.systems
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DProxy;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Display3D;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.Away3DRenderNode;

	
	public class Away3DRenderSystem extends System
	{
		public var container:DisplayObjectContainer;
		public var stage3dProxy:Stage3DProxy;
		
		private var nodes:NodeList;
		public var _view3D:View3D;
		private var _scene:Scene3D;
		
		public function Away3DRenderSystem(container:DisplayObjectContainer, stage3dproxy:Stage3DProxy)
		{
			this.container = container;
			this.stage3dProxy = stage3dproxy;
		}
		
		override public function addToGame(game:Game):void
		{
			// create view3D
			_view3D = new View3D();
			_view3D.stage3DProxy = this.stage3dProxy;
			_view3D.shareContext = true;
			container.addChild(_view3D);
			
			_scene = _view3D.scene;
			
			// init camera
			_view3D.camera.z = -240;
			_view3D.camera.y = stage3dProxy.viewPort.height / 2;
			_view3D.camera.x = stage3dProxy.viewPort.width / 2;
			
			nodes = game.getNodeList(Away3DRenderNode);
			for(var node:Away3DRenderNode = nodes.head; node; node = node.next)
			{
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
		}
		
		private function addToDisplay(node:Away3DRenderNode):void
		{
			_scene.addChild(node.display3D.object3D);
		}
		
		private function removeFromDisplay(node:Away3DRenderNode):void
		{
			_scene.removeChild(node.display3D.object3D);
		}
		
		override public function update(time:Number):void
		{
			var node:Away3DRenderNode;
			var position:Position;
			var display3D:Display3D;
			var object3D:ObjectContainer3D;
			for(node = nodes.head; node; node = node.next)
			{
				display3D = node.display3D;
				object3D = display3D.object3D;
				position = node.position;
				
				object3D.x = position.position.x;
				object3D.y = position.position.y;
				object3D.rotationZ = position.rotation * 180 / Math.PI;
			}
			
			// render the view
			stage3dProxy.clear();
			_view3D.render();
			stage3dProxy.present();
		}

		override public function removeFromGame(game:Game):void
		{
			nodes = null;
			
			container.removeChild(_view3D);
			// TODO do we need to do this?
			//_view3D.dispose();
			_view3D = null;
			_scene = null;
		}
	}
}
