	package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	//import fl.lang.Locale;
		
	public class scbzambia extends MovieClip {
		private var currentMovie:MovieClip = null;
		private var currentLink:String = "";
		private var m_xmlSequence:XML = 
			<sequence initIndex="1">
				<mov index="1" value="MovMain4" link="/zm/personal-banking/services/visa-electron-debit-card/en/"/> // 
				<mov index="2" value="MovMain1" link="/zm/personal-banking/loans/en/"/> // 
				<mov index="3" value="MovMain2" link="http://priority.standardchartered.co.zm/en/"/> //
				<mov index="4" value="MovMain5" link="/zm/sme-banking/trade-and-working-capital/en/"/> // 
				<mov index="5" value="MovMain3" link="/zm/personal-banking/services/visa-electron-debit-card/en/"/> // 
				
				
				
				
			</sequence>;
			
		public function scbzambia() {
			//Locale.setDefaultLang("vi");
			//Locale.loadLanguageXML("en");
			//trace(Locale.autoReplace);
			//trace(Locale.checkXMLStatus());
			//trace(Locale.getDefaultLang());
			
			
			// Init links from external flashVars
			initLinkFromFlashVars();
			instantiateCurrentMovie(getSequenceMovBasedOnIndex(m_xmlSequence.@initIndex).@value);
			m_mvSequenceChooser.addEventListener("select", onSelect);			
		}
		
		private function onSelect(e:ObjectEvent) {
			var currentXMLMov:XML = getSequenceMovBasedOnIndex(e.data.indexNumber);
			if (currentXMLMov != null) {
				instantiateCurrentMovie(currentXMLMov.@value);	
			}
		}
		private function getSequenceMovBasedOnIndex(index:String):XML {
			for each (var mov:XML in m_xmlSequence.mov) {
				if (mov.@index == index) {
					currentLink = mov.@link;
					return mov;					
				}
			}
			return null;
		}
		
		private function initLinkFromFlashVars():void {
			for each (var mov:XML in m_xmlSequence.mov) {
				var lnk:String = getLoaderInfo("url" + mov.@index, mov.@link);
				trace("url" + mov.@index);
				mov.@link = lnk;
			}
		}
		
		private function instantiateCurrentMovie(name:String):void {
			if (currentMovie !=null && this.contains(currentMovie)) {
				this.removeChild(currentMovie);
				currentMovie.removeEventListener("finishMov", loadNext);
			}
			//TODO Workaround now for instantiate a movie clip by its name
			if (name == "MovMain1") {
				currentMovie = new MovMain1();
			}  else if (name == "MovMain2") {
				currentMovie = new MovMain2();
			}  else if (name == "MovMain5") {
				currentMovie = new MovMain5();
				}  else if (name == "MovMain3") {
				currentMovie = new MovMain3();
				}  else if (name == "MovMain4") {
				currentMovie = new MovMain4();
			}
			
			if (currentMovie!=null && !this.contains(currentMovie)) {
				currentMovie.x = 0;
				currentMovie.y = 0;
				currentMovie.addEventListener(MouseEvent.CLICK, onMovieClick);
				currentMovie.addEventListener("finishMov", loadNext);
				this.addChildAt(currentMovie, this.getChildIndex(m_mvSequenceChooser));				
			}
		}
		
		private function loadNext(e:Event) {
			m_mvSequenceChooser.loadNext();
		}
		
		private function onMovieClick(e:Event) {
			navigateToURL(new URLRequest(currentLink), "_self");
		}
		
		private function getLoaderInfo(key:String, defaultVal:String):String {
			var obj = LoaderInfo(this.root.loaderInfo).parameters[key];
			if (obj != undefined) {
				return String(obj);
			}
			return defaultVal;
		}
	}
}
