package com.manager 
{
	import com.boomSign.BoomSign;
	import com.endPage.EndPage;
	import com.items.Items;
	import com.monster.Monster;
	import com.object.GameObject;
	import com.pausepage.PausePage;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.bullet.Bullet;	
	import com.player.Player;
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.fscommand;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent
	import com.bg.BGControl;
	import com.tools.HitTest;
	
	/**
	 * 游戏管理类
	 * @author Mack 358111542@qq.com
	 * 2013年8月26日 10:55:44
	 */
	public class GameManager extends Sprite 
	{
		/**
		 * 玩家对象
		 */
		private var _myPlayer:Player;
		/**
		 * 舞台宽
		 */
		private var _stageWidth:Number;
		/**
		 * 舞台高
		 */
		private var _stageHeight:Number;
		/**
		 * 子弹计时器
		 */
		private var _shootTimer:Timer;
		/**
		 * 子弹射击时间间隔
		 */
		private var _shootTime:Number = 200;
		/**
		 * 敌人创建计时器
		 */
		private var _createMonsterTimer:Timer;
		/**
		 * 敌人创建时间间隔
		 */
		private var _createMonsterTime:Number = 400;		
		/**
		 * 道具创建计时器
		 */
		private var _createItemsTimer:Timer;
		/**
		 * 道具创建时间间隔
		 */
		private var _createItemsTime:Number = 8000;
		/**
		 * 子弹数组
		 */
		private var _bulletArr:Array;
		/**
		 * 敌人数组
		 */
		private var _monsterArr:Array;
		/**
		 * 敌人类型所占的比例基数
		 */
		private var _randNumMonter:int;
		/**
		 * 敌人类型1，2
		 */
		private var _randTypeMonter:int;
		/**
		 * 道具类型所占的比例基数
		 */
		private var _randNumItems:int;
		/**
		 * 道具类型1，2
		 */
		private var _randTypeItems:int;
		/**
		 * 舞台对象
		 */
		private var _myStage:DisplayObject;
		/**
		 * 是否已经点击
		 */
		private var _isClick:Boolean;
		/**
		 * 声音管理对象
		 */ 
		private var _soundM:SoundManager;
		/**
		 * 当前分数
		 */
		private var _score:Number = 0;
		/**
		 * 分数文本框对象
		 */
		private var _textScore:TextField;
		/**
		 * 按钮对象
		 */
		private var _button:Sprite;
		/**
		 * 暂停页面对象
		 */ 
		private var _pause:PausePage;
		/**
		 * 结束界面
		 */
		private var _end:EndPage;
		/**
		 * 背景管理对象
		 */
		private var _bgControl:BGControl
		/**
		 * 道具数组
		 */
		private var _itemsArr:Array;
		/**
		 * 子弹类型 1单排，2双排
		 */
		private var _bulletType:int = 1;		
		/**
		 * 炸弹数量
		 */
		private var _boomNum:Number = 0;
		/**
		 * 双排子弹计时器
		 */
		private var _doubleBulletTimer:Timer;
		/**
		 * 双排子弹时间间隔,5S
		 */
		private var _doubleBulletTime:Number = 5000;		
		/**
		 * 炸弹标记对象
		 */
		private var _boomSign:BoomSign;
		
		
		/**
		 * 管理类构造函数
		 * @param	sw 舞台宽
		 * @param	sh 舞台高
		 */
		public function GameManager(sw:Number,sh:Number,sta:DisplayObject) 
		{
			_myStage = sta;
			_stageWidth = sw;
			_stageHeight = sh;			
			init();
		}
		
		/**
		 * 初始化
		 */
		private function init():void 
		{
			//背景
			this._bgControl = new BGControl();
			this.addChild(this._bgControl);
			//玩家
			_myPlayer = new Player();
			this.addChild(_myPlayer);		
			_myPlayer.x = _stageWidth / 2 - _myPlayer.width / 2;			
			_myPlayer.y = _stageHeight - _myPlayer.height;
			//道具数组
			_itemsArr = new Array();
			//子弹数组
			_bulletArr = new Array();
			//敌人数组
			_monsterArr = new Array();
			//计时器
			_shootTimer = new Timer(_shootTime, 0);
			_createMonsterTimer = new Timer(_createMonsterTime, 0);
			_createItemsTimer = new Timer(_createItemsTime, 0);	
			_doubleBulletTimer = new Timer(_doubleBulletTime, 0);
			//初始化声音管理器
			_soundM = new SoundManager();
			_soundM.initBg("resource/bgmusic.mp3");
			_soundM.initEff("resource/shoot.mp3");						
			_soundM.initEff2("resource/boom.mp3");			
			//按钮对象初始化
			_button = new ButtonResources();
			this._button.scaleX = this._button.scaleY = 0.4;
			this.addChild(_button);
			//初始化分数文本框
			_textScore = new TextField();			
			_textScore.text = "0";
			_textScore.setTextFormat(new TextFormat("宋体", 18));
			_textScore.mouseEnabled = false;
			_textScore.x = _button.width;
			this.addChild(_textScore);
			//炸弹标记对象
			_boomSign = new BoomSign();
			this.addChild(_boomSign);
			_boomSign.init(0, this._stageHeight - _boomSign.height);
			//暂停页面初始化
			_pause = new PausePage();
			_pause.x = _stageWidth / 2 - _pause.width / 2;
			_pause.y = _stageHeight / 2 - _pause.height / 2;
			this.addChild(_pause);
			//结束界面初始化
			_end = new EndPage();
			_end.x = _stageWidth / 2 - _end.width / 2;
			_end.y = _stageHeight / 2 - _end.height / 2;
			this.addChild(_end);
            //开始游戏			
			startGame();
		}
		
		/**
		 * 开始游戏
		 */
		private function startGame():void
		{
			//注册主循环
			this.addEventListener(Event.ENTER_FRAME, GameFrame);
			//注册射击监听
			_shootTimer.addEventListener("timer", shoot);
			//开始射击监听
            _shootTimer.start();
			//注册创建敌人监听
			_createMonsterTimer.addEventListener("timer", createMonster);
			//开始创建敌人监听
            _createMonsterTimer.start();
			//注册创建道具监听
			_createItemsTimer.addEventListener("timer", createItems);
			//开始创建道具监听
            _createItemsTimer.start();
			//注册双排子弹监听
			_doubleBulletTimer.addEventListener("timer", doubleBullet);		
			//注册炸弹点击监听
			_boomSign.addEventListener(MouseEvent.CLICK, boomClick);
			//注册鼠标控制函数
			_myStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_myStage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown)
			_myStage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			//注册按钮监听
			_button.addEventListener(MouseEvent.CLICK, buttonClick);
			//开始播放背景音乐
			_soundM.palyBg();
		}
		
		/**
		 * 游戏主循环
		 */
		private function GameFrame(e:Event):void 
		{
			//背景控制运行
			_bgControl.run();
			//子弹运行
			for each(var b:Bullet in _bulletArr)
			{
				if (b.isCanUse)
				{					
					b.run();
					//是否超出屏幕
					this.overstepScreen(b);
					//是否打到敌人
					this.bulletHitMonster(b, _monsterArr);
				}
			}
			//敌人运行
			for each(var m:Monster in _monsterArr)
			{
				if (m.isCanUse)
				{					
					m.run();
					//是否超出屏幕
					this.overstepScreen(m);
				}
			}
			//道具运行
			for each(var i:Items in _itemsArr)
			{
				if (i.isCanUse)
				{					
					i.run();
					//是否超出屏幕
					this.overstepScreen(i);
				}
			}
			//检测玩家与敌人碰撞
			this.playerHitMonster(_myPlayer, _monsterArr);
			//检测玩家与道具碰撞
			this.playerHitItems(_myPlayer, _itemsArr);
			//让分数文本框显示到顶层
			this.setChildIndex(_textScore, this.numChildren - 1);
			//让炸弹标记对象显示到顶层
			this.setChildIndex(_boomSign, this.numChildren - 1);
			//检测炸弹标记是否显示，当炸弹数量为0，不显示
			if (_boomNum == 0)
			{
				_boomSign.visible = false;
			}			
		}
		
		/**
		 * 子弹是否打到敌人
		 * @param	obj 子弹
		 * @param	arr 敌人数组 
		 * @return
		 */		
		private function bulletHitMonster(obj:GameObject,arr:Array):Boolean
		{
			for each(var o:GameObject in arr)
			{
				//敌人是否可用
				if (o._isCanUse)
				{
					//是否碰到
					//if (obj.hitTestObject(o))
					if(HitTest.complexHitTestObject(obj, o))
					{						
						var m:Monster = o as Monster;
						//敌人减血
						m.cutHp();
						//敌人死亡，加分
						if (m.hp == 0)
						{
							if (m.type == 1)
								_score += 6000;
							if (m.type == 2)
								_score += 1000;
							if (m.type == 3)
								_score += 12000;
							_textScore.text = _score.toString();		
							_textScore.setTextFormat(new TextFormat("宋体", 18));
							//敌人销毁
							m.die();
						}
						//子弹销毁
						obj.die();
						break;
					}					
				}
			}
			return false;
		}
		
		/**
		 * 玩家是否碰到敌人
		 * @param	obj 玩家
		 * @param	arr 敌人数组 
		 * @return
		 */		
		private function playerHitMonster(obj:GameObject,arr:Array):Boolean
		{
			for each(var o:GameObject in arr)
			{
				//敌人是否可用
				if (o._isCanUse)
				{
					//是否碰到
					//if (obj.hitTestObject(o))
					if (HitTest.complexHitTestObject(obj, o))
					{
						//玩家死亡
						o.die();
						//敌人死亡
						obj.die();
						//停止游戏
						this.stopGame();
						//显示结束界面
						_end.visible = true;
						//结束界面设置分数
						_end.setScore(_score);
						//结束界面设置到顶层
						this.setChildIndex(_end, this.numChildren - 1);
						//结束界面监听鼠标
						_end.addEventListener(MouseEvent.CLICK, endHanlder);
						_button.removeEventListener(MouseEvent.CLICK, buttonClick);
					}
					
				}
			}
			return false;
		}
		
		/**
		 * 结束界面鼠标监听		 
		 */
		private function endHanlder(e:MouseEvent):void 
		{
			if (e.target.name == "btn_Back")	
			{
				this.reStart();
				_end.visible = false;
			}
		}
		
		/**
		 * 玩家是否碰到道具
		 * @param	obj 玩家
		 * @param	arr 道具数组 
		 * @return
		 */		
		private function playerHitItems(obj:GameObject,arr:Array):Boolean
		{
			for each(var o:GameObject in arr)
			{
				//道具是否可用
				if (o._isCanUse)
				{
					//是否碰到
					//if (obj.hitTestObject(o))
					if(HitTest.complexHitTestObject(obj, o))
					{			
						//道具死亡
						o.die();
						//双排子弹道具
						if (o._type == 1)
						{
							//双排子弹
							_bulletType = 2;
							//双排子弹持续时间监听重置
							_doubleBulletTimer.reset();
							//双排子弹持续时间监听开始
							_doubleBulletTimer.start();
						}
						//炸弹道具
						if (o._type == 2)
						{
							//炸弹
							_boomNum++;
							//设置炸弹标记文本框
							_boomSign.setBoomNumber(_boomNum);
							//炸弹标记对象可见
							_boomSign.visible = true;
						}						
					}					
				}
			}
			return false;
		}
		
		/**
		 * 炸弹标记点击
		 */
		private function boomClick(e:MouseEvent):void 
		{
			//标记可见，并且炸弹数量！=0
			if (_boomSign.visible && _boomNum!=0)
			{
				//全屏秒杀，并统计分数
				screenAllKill(_monsterArr);
				//减少炸弹数量
				_boomNum--;
				//设置炸弹标记文本框
				_boomSign.setBoomNumber(_boomNum);
			}
		}
		/**
		 * 全屏秒杀，并统计分数
		 */
		private function screenAllKill(arr:Array):void
		{
			//播放炸弹音效
			_soundM.palyEff2();
			//杀死所有可用的敌人，并计算分数
			for each(var o:GameObject in arr)
			{
				var m:Monster = o as Monster;
				if (m._isCanUse)
				{								
					if (m.type == 1)
						_score += 6000;
					if (m.type == 2)
						_score += 1000;
					if (m.type == 3)
						_score += 12000;	
					_textScore.text = _score.toString();		
					_textScore.setTextFormat(new TextFormat("宋体", 18));	
					//敌人死亡
					m.die();
				}
			}
		}
		
		/**
		 * 是否超出屏幕
		 * @return
		 */
		private function overstepScreen(obj:GameObject):Boolean
		{
			if (obj.y > _stageHeight || obj.y < 0 - obj.height)
			{
				//超出的对象死亡
				obj.die();
				return true;
			}
			return false;
		}
		
		/**
		 * 鼠标松开		 
		 */
		private function mouseUp(e:MouseEvent):void 
		{
			_isClick = false;
		}
		
		/**
		 * 鼠标按下
		 */
		private function mouseDown(e:MouseEvent):void 
		{
			if (e.target == "[object PlayerResources]")
				_isClick = true;		
			else
				_isClick = false;
		}
		
		/**
		 * 鼠标移动，玩家移动
		 */
		private function mouseMove(e:MouseEvent):void 
		{
			if(_isClick)
			{
				//左边超出边界
				if (e.stageX-_myPlayer.width/2 < 0)
					_myPlayer.x = 0;
				//右边超出边界	
				if (e.stageX + _myPlayer.width / 2 > _stageWidth)					
					_myPlayer.x = _stageWidth - _myPlayer.width;
				//横向没有超出边界	
				if (e.stageX - _myPlayer.width / 2 >= 0 && e.stageX + _myPlayer.width / 2 <= _stageWidth)					
					_myPlayer.x = e.stageX - _myPlayer.width / 2;		
				//上边超出边界	
				if (e.stageY - _myPlayer.height / 2 < 0)
					_myPlayer.y = 0;
				//下边超出边界	
				if (e.stageY + _myPlayer.height / 2 > _stageHeight)
					_myPlayer.y = _stageHeight - _myPlayer.height;					
				//纵向没有超出边界	
				if (e.stageY - _myPlayer.height / 2 >= 0	&& e.stageY + _myPlayer.height / 2 <= _stageHeight)				
					_myPlayer.y = e.stageY - _myPlayer.height / 2;
			}			
		}
		
		/**
		 * 暂停按钮鼠标监听
		 */
		private function buttonClick(e:MouseEvent):void 
		{
			//停止游戏
			this.stopGame();			
			//显示暂停界面
			_pause.visible = true;
			//暂停界面调到顶层
			this.setChildIndex(_pause, this.numChildren - 1);
			//注册暂停界面鼠标监听
			_pause.addEventListener(MouseEvent.CLICK, pauseHanlder);
		}
		
		/**
		 * 暂停界面鼠标监听		 
		 */
		private function pauseHanlder(e:MouseEvent):void 
		{
			//移除监听
			_pause.removeEventListener(MouseEvent.CLICK, pauseHanlder);
			//返回按钮
			if (e.target.name == "btn_Back")	
			{
				//开始游戏
				this.startGame();
				//暂停界面不可见
				_pause.visible = false;
			}
			//重玩按钮
			if (e.target.name == "btn_Restart")
			{
				//重开游戏
				this.reStart();
				//暂停界面不可见
				_pause.visible = false;				
				
			}
			//退出按钮
			if (e.target.name == "btn_Exit")
			{
				fscommand("quit");
				this.destroy();
			}
		}
		
		/**
		 * 重开游戏，各种初始化与重置
		 */
		private function reStart():void
		{
			this.arrDie(_bulletArr);
			this.arrDie(_monsterArr);
			this.arrDie(_itemsArr);
			_bulletArr.length = 0;
			_monsterArr.length = 0;
			_itemsArr.length = 0;
			_myPlayer.x = _stageWidth / 2 - _myPlayer.width / 2;			
			_myPlayer.y = _stageHeight - _myPlayer.height;				
			_score = 0;
			_boomNum = 0;
			_bulletType = 1;
			_textScore.text = _score.toString();		
			_textScore.setTextFormat(new TextFormat("宋体", 18));	
			_createItemsTimer.reset();
			_createMonsterTimer.reset();
			_doubleBulletTimer.reset();
			_shootTimer.reset();
			_myPlayer.visible = true;
			//开始游戏
			this.startGame();			
		}
		
		/**
		 * 数组里对象全部死亡
		 */
		private function arrDie(arr:Array):void
		{
			for each(var o:GameObject in arr)
			{
				o.die();
			}
		}			
		
		/**
		 * 双排子弹时间监听
		 */
		private function doubleBullet(e:TimerEvent):void 
		{
			//到时间，变回单发子弹
			_bulletType = 1;
			//计时器重置
			_doubleBulletTimer.reset();
		}
		
		/**
		 * 创建敌人函数		 
		 */
		private function createMonster(e:TimerEvent):void 
		{
			//随机百分比常数
			_randNumMonter = Math.random() * 100 + 1;
			//让敌人类型2占80%，1占18%，3占8%
			if (_randNumMonter > 0 && _randNumMonter <= 80)
				_randTypeMonter = 2;
			else if (_randNumMonter > 80 && _randNumMonter <= 98)
				_randTypeMonter = 1;
			else if (_randNumMonter > 98 && _randNumMonter <= 100)
				_randTypeMonter = 3;	
			var tmpM:Monster;	
			//从敌人数组取没有飞出能用的敌人			 
			for each(var m:Monster in _monsterArr)
			{
				if (!m.isCanUse)
				{
					tmpM = m;
					break;
				}
			}
			//没有在敌人数组中获取到未飞出能用的敌人，就再创建一个，放进去
			if (!tmpM)
			{
				tmpM = new Monster(_randNumMonter);				
				_monsterArr.push(tmpM);
				this.addChild(tmpM);
			}
			var monsterX:Number = this.randMonsterX(tmpM.getWidthByType(_randTypeMonter));			
			var monsterY:Number = 0 - tmpM.height;
			var monsterV:Number = Math.random() * 2 + 2;
			tmpM.init(monsterX, monsterY, monsterV, _randTypeMonter);
		}
		
		/**
		 * 随机敌人X坐标		
		 */
		private function randMonsterX(monsterW:Number):Number
		{
			var tmpX:Number = Math.random() * _stageWidth + 10;
			if (tmpX + monsterW >= _stageWidth)			
			{				
				tmpX = _stageWidth - 10 - monsterW;
			}
			return tmpX;
		}		
		
		/**
		 * 停止游戏函数
		 */
		private function stopGame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, GameFrame);
			this._boomSign.removeEventListener(MouseEvent.CLICK, boomClick);
			_createItemsTimer.stop();
			_shootTimer.stop();
            _createMonsterTimer.stop();
			_soundM.stopBg();
		}
				
		/**
		 * 射击函数
		 */
		private function shoot(event:TimerEvent):void
		{
			var tmpB:Bullet;	
			//从子弹数组中获取可用的子弹
			for each(var b:Bullet in _bulletArr)
			{
				if (!b.isCanUse)
				{
					tmpB = b;
					break;
				}
			}
			//没有在子弹数组中获取到可用子弹，就再创建一个，放进去
			if (!tmpB)
			{
				tmpB = new Bullet();
				_bulletArr.push(tmpB);
				this.addChild(tmpB);
			}
			//单排子弹
			if (_bulletType == 1)
			{
				var bulletX:Number = (_myPlayer.x + _myPlayer.width / 2) - tmpB.width / 2;			
				var bulletY:Number = _myPlayer.y - tmpB.height;
				tmpB.init(bulletX, bulletY);
			}
			//双排子弹
			if (_bulletType == 2)
			{
				var bulletX1:Number = (_myPlayer.x + _myPlayer.width / 2) - tmpB.width / 2 - 10;				
				var bulletY1:Number = _myPlayer.y - tmpB.height;
				tmpB.init(bulletX1, bulletY1);
				var tmpB2:Bullet = tmpB.myClone(tmpB);
				_bulletArr.push(tmpB2);
				this.addChild(tmpB2);
				var bulletX2:Number = (_myPlayer.x + _myPlayer.width / 2) - tmpB.width / 2 + 10;
				var bulletY2:Number = _myPlayer.y - tmpB.height;				
				tmpB2.init(bulletX2, bulletY2);				
			}			
			//播放子弹音效
			_soundM.palyEff();
		}
		
		/**
		 * 创建道具
		 */
		private function createItems(e:Event):void 
		{
			//随机百分比常数
			_randNumItems = Math.random() * 100 + 1;
			//让道具类型2占20%，1占70%
			if (_randNumItems > 0 && _randNumItems <= 70)
				_randTypeItems = 1;
			else
				_randTypeItems = 2;
			var tmpI:Items;
			for each(var i:Items in _itemsArr)
			{
				if (!i.isCanUse)
				{
					tmpI = i;
					break;
				}
			}
			//没有在道具数组中获取到可用道具，就再创建一个，放进去
			if (!tmpI)
			{
				tmpI = new Items(_randNumItems);
				_itemsArr.push(tmpI);
				this.addChild(tmpI);
			}			
			var itemsX:Number = this.randItemsX(tmpI.getWidthByType(_randTypeItems));			
			var itemsY:Number = 0 - tmpI.height;
			var itemsV:Number = Math.random() * 2 + 2;
			tmpI.init(itemsX, itemsY, itemsV, _randTypeItems);		
		}
		
		/**
		 * 随机道具X坐标
		 */
		private function randItemsX(itemsW:Number):Number
		{
			var tmpX:Number = Math.random() * _stageWidth + 10;
			if (tmpX + itemsW >= _stageWidth)			
			{				
				tmpX = _stageWidth - 10 - itemsW;
			}
			return tmpX;
		}
		
		/**
		 * 销毁
		 */
		public function destroy():void
		{
			//游戏管理器不可见
			this.visible = false;
			//销毁背景
			this.removeChild(_bgControl);
			_bgControl.destroy();
			_bgControl = null;
			//销毁玩家
			this.removeChild(_myPlayer);
			_myPlayer.destroy();
			_myPlayer = null;
			//销毁音乐
			_soundM.destroy();
			_soundM = null;
			//销毁暂停按钮
			this.removeChild(_button);
			_button = null;
			//销毁分数文本框
			this.removeChild(_textScore);			
			_textScore = null;
			//销毁炸弹标记
			this.removeChild(_boomSign);
			_boomSign.destroy();
			_boomSign = null;
			//销毁暂停界面
			this.removeChild(_pause);
			_pause.destroy();
			_pause = null;
			//销毁结束界面
			this.removeChild(_end);
			_end.destroy();			
			_end = null;
			//卸载主循环
			this.removeEventListener(Event.ENTER_FRAME, GameFrame);
			//卸载射击监听
			_shootTimer.removeEventListener("timer", shoot);
			//卸载创建敌人监听
			_createMonsterTimer.removeEventListener("timer", createMonster);
			//卸载创建道具监听
			_createItemsTimer.removeEventListener("timer", createItems);
			//卸载双排子弹监听
			_doubleBulletTimer.removeEventListener("timer", doubleBullet);		
			//卸载炸弹点击监听
			_boomSign.removeEventListener(MouseEvent.CLICK, boomClick);
			//卸载鼠标控制函数
			_myStage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_myStage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown)
			_myStage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			//卸载按钮监听
			_button.removeEventListener(MouseEvent.CLICK, buttonClick);
			//卸载暂停界面监听
			_pause.removeEventListener(MouseEvent.CLICK, pauseHanlder);
			//卸载结束界面监听
			_end.removeEventListener(MouseEvent.CLICK, endHanlder);
			//销毁计时器
			_createItemsTimer = null;
			_shootTimer = null;
            _createMonsterTimer = null;	
			_doubleBulletTimer = null;
			//销毁数组
			this.arrDie(_bulletArr);
			this.arrDie(_monsterArr);
			this.arrDie(_itemsArr);
			_bulletArr.length = 0;
			_monsterArr.length = 0;
			_itemsArr.length = 0;
			_bulletArr = null;
			_monsterArr = null;
			_itemsArr = null;
		}
	}
}