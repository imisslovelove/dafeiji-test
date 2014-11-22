package com.items 
{
	import com.object.GameObject;
	import flash.display.MovieClip;
	
	/**
	 * 道具类
	 * @author Mack 358111542@qq.com
	 * 2013年8月29日 18:28:44
	 */
	public class Items extends GameObject 
	{
		/**
		 * 道具资源对象
		 */
		private var _items:MovieClip;
		/**
		 * 道具下落速度
		 */
		private var _speedY:int = 3;		
				
		public function Items(type:int) 
		{
			//创建资源对象
			_items = new ItemsResources();
			//跳到某样式敌人所对应的帧，为了有初始宽高属性
			_items.gotoAndStop(type);
			//添加到显示列表
			this.addChild(_items);
			//显示比例
			this._items.scaleX = this._items.scaleY = 0.4;
		}
		
		/**
		 * 道具初始化
		 * @param	x 舞台X
		 * @param	y 舞台Y
		 * @param	v Y轴移动速度
		 * @param	type 道具类型
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
			_items.gotoAndStop(type);			
		}
		
		/**
		 * 通过样式得到宽度
		 * @param	type 样式
		 * @return 宽度
		 */
		public function getWidthByType(type:int):Number
		{
			_items.gotoAndStop(type);	
			return this.width;
		}
		
		/**
		 * 道具运行
		 */
		override public function run():void
		{
			//看不见的道具直接不管
			if (!_isCanUse)
				return;
			//看得见的让它继续向下运动
			this.y += _speedY;
		}
		/**
		 * 道具死亡
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
			this.removeChild(_items);
			_items = null;
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