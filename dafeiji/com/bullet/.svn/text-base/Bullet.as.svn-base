package com.bullet 
{
	import com.object.GameObject;
	import flash.display.Sprite;
	
	/**
	 * 子弹类
	 * @author Mack 358111542@qq.com
	 * 2013年8月26日 10:54:53
	 */
	public class Bullet extends GameObject 
	{		
		/**
		 * 子弹资源对象
		 */
		private var _bullet:Sprite;
		/**
		 * 子弹下落速度
		 */
		private var _speedY:int = 15;	
						
		public function Bullet() 
		{	
			//创建资源对象
			_bullet = new BulletResources();
			//添加到显示列表
			this.addChild(_bullet);			
			//显示比例
			this._bullet.scaleX = this._bullet.scaleY = 0.4;
		}
		
		/**
		 * 子弹克隆函数，单发变双发
		 * @param	b 需要克隆的子弹
		 * @return 克隆完成的子弹
		 */
		public function myClone(b:Bullet):Bullet
		{
			var cloneB:Bullet = new Bullet();
			cloneB._speedY = b._speedY;
			cloneB._bullet = b._bullet;
			cloneB._isCanUse = b._isCanUse;
			cloneB._type = b._type;
			return cloneB;
		}
		
		/**
		 * 初始化子弹
		 * @param	x 舞台X
		 * @param	y 舞台Y
		 */
		public function init(x:Number,y:Number):void
		{
			this.x = x;
			this.y = y;
			_isCanUse = true;
			this.visible = true;
		}
		
		/**
		 * 子弹运行
		 */
		override public function run():void
		{
			//未射出的子弹直接不管
			if (!_isCanUse)
				return;
			//射出的子弹让它继续向上运动
			this.y -= _speedY;
		}
		
		/**
		 * 子弹死亡
		 */
		override public function die():void
		{
			isCanUse = false;
			this.visible = false;
		}
		
		/**
		 * 销毁
		 */
		override public function destroy():void
		{
			this.visible = false;
			this.removeChild(_bullet);
			_bullet = null;
		}
		
		public function get isCanUse():Boolean 
		{
			return _isCanUse;
		}
		
		public function set isCanUse(value:Boolean):void 
		{
			_isCanUse = value;
		}
		
	}

}