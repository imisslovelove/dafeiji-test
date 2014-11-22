package com.player 
{
	import com.bullet.Bullet;
	import com.object.GameObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	/**
	 * 玩家类
	 * @author Mack 358111542@qq.com
	 * 2013年8月26日 10:15:41
	 */
	public class Player extends GameObject
	{		
		/**
		 * 玩家资源对象
		 */
		private var _player:Sprite;
		
		public function Player():void
		{
			//默认显示
			this.visible = true;
			//创建资源对象
			_player = new PlayerResources();
			//添加到显示列表
			this.addChild(_player);			
			//显示比例
			this._player.scaleX = this._player.scaleY = 0.4;			
		}		
		
		/**
		 * 玩家死亡
		 */
		override public function die():void
		{
			this.visible = false;
		}
		
		/**
		 * 销毁
		 */
		override public function destroy():void
		{
			this.visible = false;
			this.removeChild(_player);
			_player = null;
		}
		
	}

}