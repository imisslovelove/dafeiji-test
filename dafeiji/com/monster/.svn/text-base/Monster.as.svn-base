package com.monster 
{
	import com.object.GameObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 敌人类
	 * @author Mack 358111542@qq.com
	 * 2013年8月26日 15:37:49
	 */
	public class Monster extends GameObject 
	{	
		/**
		 *敌人资源对象
		 */
		private var _monster:MovieClip;
		/**
		 * 敌人下落速度
		 */
		private var _speedY:int = 3;
		/**
		 * 敌人生命值
		 */
		private var _hp:int;			
		
		public function Monster(type:int) 		
		{			
			//创建资源对象
			_monster = new MonsterResources();
			//跳到某样式敌人所对应的帧，为了有初始宽高属性
			_monster.gotoAndStop(type);
			//添加到显示列表
			this.addChild(_monster);
			//显示比例
			this._monster.scaleX = this._monster.scaleY = 0.4;
		}
		
		/**
		 * 敌人初始化
		 * @param	x 舞台X
		 * @param	y 舞台Y
		 * @param	v Y轴移动速度
		 * @param	type 敌人类型
		 */
		public function init(x:Number,y:Number,v:Number,type:int):void
		{
			this.x = x;
			this.y = y;
			this._speedY = v;		
			this._type = type;
			_isCanUse = true;
			this.visible = true;
			//根据式样跳到对应帧
			_monster.gotoAndStop(type);
			//根据式样初始化生命值
			if (this._type == 1)
				this._hp = 5;
			if (this._type == 2)
				this._hp = 1;	
			if (this._type == 3)
				this._hp = 10;			
		}
		
		/**
		 * 通过样式得到宽度
		 * @param	type 样式
		 * @return 宽度
		 */
		public function getWidthByType(type:int):Number
		{
			_monster.gotoAndStop(type);
			return this.width;
		}
		
		/**
		 * 减血
		 */
		public function cutHp()
		{
			this._hp--;
			if (this._hp == 0)
				this.die();
		}
		
		/**
		 * 敌人运行
		 */
		override public function run():void
		{
			//看不见的敌人直接不管
			if (!_isCanUse)
				return;
			//看得见的让它继续向下运动
			this.y += _speedY;
		}
		
		/**
		 * 敌人死亡
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
			this.removeChild(_monster);
			_monster = null;			
		}
		
		public function get isCanUse():Boolean 
		{
			return _isCanUse;
		}
		
		public function set isCanUse(value:Boolean):void 
		{
			_isCanUse = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get hp():int 
		{
			return _hp;
		}
		
		public function set hp(value:int):void 
		{
			_hp = value;
		}
				
	}

}