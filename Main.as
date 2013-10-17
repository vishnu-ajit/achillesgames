package  
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.utils.Timer;
	import mochi.as3.*;
	public class Main extends MovieClip
	{
		private var wordsArray:Array = new Array("AWESOME", "GOLDEN","BULL","GANGSTER","BLACK","JANUARY","QUEEN","FUNNY","TENDER","POISON","MUSIC","FREEDOM","SEVEN","NATIONAL","DIAMOND","NYLON","SHUTTER","REEL","SADDLE","CHALK","STORY","THRONE","EMPIRE");
		private var keyboardTopLineArray:Array = new Array("Q","W","E","R","T","Y","U","I","O","P");
		private var keyboardMiddleLineArray:Array = new Array("A","S","D","F","G","H","J","K","L");
		private var keyboardBottomLineArray:Array = new Array("Z","X","C","V","B","N","M");
		public var currentGuessWord:String;
		public var guessIndex:uint;
		private var guessTilesArray:Array;
		private var correct:uint;
		private var wrong:uint;
		private var score:uint;
		private var numOfAlphabets:uint;
		private var totalTimeLeft:uint = 30;
		private var secondTicker:Timer;
		private var keyboardTilesOnStageArray:Array;
		
		public function Main() 
		{
			guessIndex = 0;
			correct = 0;
			wrong = 0;
			score = 0;
			
			
			MochiAd.showPreGameAd({clip:mcMochiAd, id:"adf3fc436c4cc12a", res:"800x600"});
			
			
			//click_to_play_mc.addEventListener(MouseEvent.CLICK,playClickListener);
			
		}
		private function playClickListener(evt:MouseEvent)
		{
			guessIndex = 0;
			correct = 0;
			wrong = 0;
			score = 0;
			totalTimeLeft = 30;
			keyboardTilesOnStageArray = new Array();
			gotoAndStop(10);
			layoutTheKeyboard();
			getEnglishWord();
			timeleft.text = ""+30;
			secondTicker = new Timer(1000,30);
			secondTicker.addEventListener(TimerEvent.TIMER,secondTimer);
			secondTicker.addEventListener(TimerEvent.TIMER_COMPLETE,timeComplete);
			secondTicker.start();
		}
		private function timeComplete(evt:TimerEvent)
		{
			var clip:MovieClip;
			for(var i:uint = 0; i < keyboardTilesOnStageArray.length; i++)
			{
				clip = keyboardTilesOnStageArray[i] as MovieClip;
				if(clip)
				{
					this.removeChild(clip);
				}
				
			}
			for(var i:uint = 0; i < guessTilesArray.length; i++)
			{
				clip = guessTilesArray[i] as MovieClip;
				if(clip)
				{
					this.removeChild(clip);
				}
				
			}
			
			
			gotoAndStop(20);
			play_again_mc.addEventListener(MouseEvent.CLICK,playClickListener);
			scoreObtained.text = ""+score;
		}
		private function secondTimer(evt:TimerEvent)
		{
			totalTimeLeft -= 1;
			timeleft.text = ""+totalTimeLeft;
		}
		private function layoutTheKeyboard()
		{
			var i:uint;
			var key:Key;
			var numOfAlphabets:uint = keyboardTopLineArray.length;
			for(i = 0; i < numOfAlphabets; i++)
			{
				key = new Key();				
				this.addChild(key);
				keyboardTilesOnStageArray.push(key);
				key.x = 100+ (i * key.width) + 10*i;
				key.y = 400;				
				key["value"].text = ""+keyboardTopLineArray[i];
				key.name = ""+keyboardTopLineArray[i];
				key.addEventListener(MouseEvent.CLICK, keyClickedListener);
			}
			numOfAlphabets = keyboardMiddleLineArray.length;
			for( i = 0; i < numOfAlphabets; i++)
			{
				key = new Key();				
				this.addChild(key);
				keyboardTilesOnStageArray.push(key);
				key.x = 115+ (i * key.width) + 10*i;
				key.y = 400 + key.height + 10;				
				key["value"].text = ""+keyboardMiddleLineArray[i];
				key.name = ""+keyboardMiddleLineArray[i];
				key.addEventListener(MouseEvent.CLICK, keyClickedListener);
			}
			numOfAlphabets = keyboardBottomLineArray.length;
			for(i = 0; i < numOfAlphabets; i++)
			{
				key = new Key();				
				this.addChild(key);
				keyboardTilesOnStageArray.push(key);
				key.x = 140+ (i * key.width) + 10*i;
				key.y = 400 + (2*key.height) + 20;				
				key["value"].text = ""+keyboardBottomLineArray[i];
				key.name = ""+keyboardBottomLineArray[i];
				key.addEventListener(MouseEvent.CLICK, keyClickedListener);
			}
		}
		
		private function keyClickedListener(evt:MouseEvent):void
		{
			var clickedKey:MovieClip = evt.currentTarget as MovieClip;
			var charValue:String= clickedKey["value"].text;
			trace ('charValue:'+charValue);
			if(currentGuessWord.charAt(guessIndex) == charValue)
			{
				
				var toBePoppedTile:MovieClip = guessTilesArray[guessIndex];
				//guessTilesArray.splice(guessIndex,1);
				//toBePoppedTile.visible = false;
				toBePoppedTile["textMask"].height = 80.0;
				trace('numOfAlphabets='+numOfAlphabets);
				trace('guessIndex='+guessIndex);
				
				guessIndex++;
				correct++;

				correctGuesses.text = ""+correct;
				score += 10;
				totalscore.text = ""+score;
				
				if (guessIndex==numOfAlphabets)
				{
					guessIndex=0;
					for(var i:uint = 0; i < guessTilesArray.length; i++)
					{
						var guesstile:MovieClip = guessTilesArray[i] as MovieClip;
						this.removeChild(guesstile);
					}
					getEnglishWord();
				}
			}
			else
			{
				wrong++;
				wrongGuesses.text = ""+wrong;
				
			}
			
		}
		private function getEnglishWord()
		{
			var index:uint = Math.floor(Math.random()* wordsArray.length);
			var randomWord:String = wordsArray[index];
			trace("random word is "+ randomWord);
			currentGuessWord=randomWord;
			numOfAlphabets = randomWord.length;
			
			guessTilesArray = new Array();
			guessTilesArray.splice(0);
			var startOffsetX:uint = 0;
			
			var tileNote_0:TileNote_0 = new TileNote_0();
			this.addChild(tileNote_0);
			
			startOffsetX =  tileNote_0.width;
			tileNote_0.x = startOffsetX-40;
			tileNote_0.y = 100;
			tileNote_0["textMask"].visible = false;
			tileNote_0["value"].text = ""+randomWord.charAt(0);
			guessTilesArray.push(tileNote_0);
			
			for(var i:uint = 1; i < numOfAlphabets-1; i++)
			{
				var tileNote_1:TileNote_1 = new TileNote_1();
				this.addChild(tileNote_1);
				
				startOffsetX += tileNote_1.width +3;
				tileNote_1.x = startOffsetX;
				tileNote_1.y = 100;
				tileNote_1["textMask"].visible = false;
				tileNote_1["value"].text = ""+randomWord.charAt(i);
				
				guessTilesArray.push(tileNote_1);
			}
			var tileNote_2:TileNote_2 = new TileNote_2();
			this.addChild(tileNote_2);
			
			startOffsetX += tileNote_2.width - 37;
			tileNote_2.x = startOffsetX ;
			tileNote_2.y = 100;
			tileNote_2["textMask"].visible = false;
			tileNote_2["value"].text = ""+randomWord.charAt(numOfAlphabets - 1);
			guessTilesArray.push(tileNote_2);
			
			
			
		}
		
	}
	
}
