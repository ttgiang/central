/*
*
* jQuery listnav plugin
* Copyright (c) 2009 iHwy, Inc.
* Author: Jack Killpatrick
*
* Version 2.1 (08/09/2009)
* Requires jQuery 1.3.2, jquery 1.2.6 or jquery 1.2.x plus the jquery dimensions plugin
*
* Visit http://www.ihwy.com/labs/jquery-listnav-plugin.aspx for more information.
*
* Dual licensed under the MIT and GPL licenses:
*   http://www.opensource.org/licenses/mit-license.php
*   http://www.gnu.org/licenses/gpl.html
*
*/

//eval(function(p, a, c, k, e, r) { e = function(c) { return (c < a ? '' : e(parseInt(c / a))) + ((c = c % a) > 35 ? String.fromCharCode(c + 29) : c.toString(36)) }; if (!''.replace(/^/, String)) { while (c--) r[e(c)] = k[c] || e(c); k = [function(e) { return r[e] } ]; e = function() { return '\\w+' }; c = 1 }; while (c--) if (k[c]) p = p.replace(new RegExp('\\b' + e(c) + '\\b', 'g'), k[c]); return p } ('(3($){$.15.16=3(f){4 g=$.1O({},$.15.16.1m,f);4 h=[\'T\',\'a\',\'b\',\'c\',\'d\',\'e\',\'f\',\'g\',\'h\',\'i\',\'j\',\'k\',\'l\',\'m\',\'n\',\'o\',\'p\',\'q\',\'r\',\'s\',\'t\',\'u\',\'v\',\'w\',\'x\',\'y\',\'z\',\'-\'];4 j=E;g.K=$.1P(g.K,3(n){F n.17()});F 7.1n(3(){4 d,8,$8,$5,$G,U;U=7.U;d=$(\'#\'+U+\'-1Q\');$8=$(7);4 e={},18=0,V=A,1R=0,X=\'\';3 1o(){d.1p(1q());$5=$(\'.6-5\',d).L(0,1);2(g.M)$G=$(\'.6-1r-1s\',d).L(0,1);1t();1u();2(g.1v)1w();1x();2(!g.Y)$8.N();2(!g.Y)$(\'.O\',$5).19();2(!g.1a)$(\'.T\',$5).19();2(!g.1S)$(\'.-\',$5).19();$(\':1y\',$5).P(\'6-1y\');2($.Z&&(g.Q!=H)){4 a=$.Z(g.Q);2(a!=H)g.10=a}2(g.10!=\'\'){j=A;$(\'.\'+g.10.17(),$5).L(0,1).1b()}D{2(g.Y)$(\'.O\',$5).P(\'6-11\');D{1c(4 i=((g.1a)?0:1);i<h.I;i++){2(e[h[i]]>0){j=A;$(\'.\'+h[i],$5).L(0,1).1b();1T}}}}}3 1z(){$G.1A({1d:$(\'.a\',$5).L(0,1).1U({1e:E,1V:A}).1d-$G.1W({1e:A})})}3 1t(){4 a,J,1X,R,$7,1B=(g.K.I>0);$($8).B().1n(3(){$7=$(7),J=\'\',a=$.1Y($7.1C()).17();2(a!=\'\'){2(1B){R=a.1f(\' \');2((R.I>1)&&($.1Z(R[0],g.K)>-1)){J=R[1].1D(0);1g(J,$7,A)}}J=a.1D(0);1g(J,$7)}})}3 1g(a,b,c){2(/\\W/.20(a))a=\'-\';2(!21(a))a=\'T\';b.P(\'6-\'+a);2(e[a]==1h)e[a]=0;e[a]++;2(!c)18++}3 1w(){1c(4 i=0;i<h.I;i++){2(e[h[i]]==1h)$(\'.\'+h[i],$5).P(\'6-22\')}}3 1u(){$8.1p(\'<1E C="6-12-13" 1F="1G:1H">\'+g.1I+\'</1E>\')}3 1i(a){2($(a).23(\'O\'))F 18;D{4 b=e[$(a).1J(\'C\').1f(\' \')[0]];F(b!=1h)?b:0}}3 1x(){2(g.M){d.1K(3(){1z()})}2(g.M){$(\'a\',$5).1K(3(){4 a=$(7).1L().1j;4 b=($(7).24({1e:A})-1)+\'25\';4 c=1i(7);$G.1A({1j:a,1M:b}).1C(c).N()});$(\'a\',$5).26(3(){$G.S()})}$(\'a\',$5).1b(3(){$(\'a.6-11\',$5).27(\'6-11\');4 a=$(7).1J(\'C\').1f(\' \')[0];2(a==\'O\'){$8.B().N();$8.B(\'.6-12-13\').S();V=A}D{2(V){$8.B().S();V=E}D 2(X!=\'\')$8.B(\'.6-\'+X).S();4 b=1i(7);2(b>0){$8.B(\'.6-12-13\').S();$8.B(\'.6-\'+a).N()}D $8.B(\'.6-12-13\').N();X=a}2($.Z&&(g.Q!=H))$.Z(g.Q,a);$(7).P(\'6-11\');$(7).28();2(!j&&(g.1k!=H))g.1k(a);D j=E;F E})}3 1q(){4 a=[];1c(4 i=1;i<h.I;i++){2(a.I==0)a.1N(\'<a C="O" 1l="#">29</a><a C="T" 1l="#">0-9</a>\');a.1N(\'<a C="\'+h[i]+\'" 1l="#">\'+((h[i]==\'-\')?\'...\':h[i].2a())+\'</a>\')}F\'<14 C="6-5">\'+a.2b(\'\')+\'</14>\'+((g.M)?\'<14 C="6-1r-1s" 1F="1G:1H; 1L:2c; 1d:0; 1j:0; 1M:2d;">0</14>\':\'\')}1o()})};$.15.16.1m={10:\'\',Y:A,2e:E,1a:A,1v:A,1I:\'2f 2g 2h\',M:A,Q:H,1k:H,K:[]}})(2i);', 62, 143, '||if|function|var|letters|ln|this|list||||||||||||||||||||||||||||true|children|class|else|false|return|letterCount|null|length|firstChar|prefixes|slice|showCounts|show|all|addClass|cookieName|spl|hide|_|id|isAll||prevLetter|includeAll|cookie|initLetter|selected|no|match|div|fn|listnav|toLowerCase|allCount|remove|includeNums|click|for|top|margin|split|addLetterClass|undefined|getLetterCount|left|onClick|href|defaults|each|init|append|createLettersHtml|letter|count|addClasses|addNoMatchLI|flagDisabled|addDisabledClass|bindHandlers|last|setLetterCountTop|css|hasPrefixes|text|charAt|li|style|display|none|noMatchText|attr|mouseover|position|width|push|extend|map|nav|numCount|includeOther|break|offset|border|outerHeight|firstWord|trim|inArray|test|isNaN|disabled|hasClass|outerWidth|px|mouseout|removeClass|blur|ALL|toUpperCase|join|absolute|20px|incudeOther|No|matching|entries|jQuery'.split('|'), 0, {}))

(function ($) {
   $.fn.listnav = function (f) {
      var g = $.extend({}, $.fn.listnav.defaults, f);
      var h = ['_', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '-'];
      var j = false;
      g.prefixes = $.map(g.prefixes, function (n) {
         return n.toLowerCase()
      });
      return this.each(function () {
         var d, list, $list, $letters, $letterCount, id;
         id = this.id;
         d = $('#' + id + '-nav');
         $list = $(this);
         var e = {},
            allCount = 0,
            isAll = true,
            numCount = 0,
            prevLetter = '';

         function init() {
            d.append(createLettersHtml());
            $letters = $('.ln-letters', d).slice(0, 1);
            if (g.showCounts) $letterCount = $('.ln-letter-count', d).slice(0, 1);
            addClasses();
            addNoMatchLI();
            if (g.flagDisabled) addDisabledClass();
            bindHandlers();
            if (!g.includeAll) $list.show();
            if (!g.includeAll) $('.all', $letters).remove();
            if (!g.includeNums) $('._', $letters).remove();
            if (!g.includeOther) $('.-', $letters).remove();
            $(':last', $letters).addClass('ln-last');
            if ($.cookie && (g.cookieName != null)) {
               var a = $.cookie(g.cookieName);
               if (a != null) g.initLetter = a
            }
            if (g.initLetter != '') {
               j = true;
               $('.' + g.initLetter.toLowerCase(), $letters).slice(0, 1).click()
            } else {
               if (g.includeAll) $('.all', $letters).addClass('ln-selected');
               else {
                  for (var i = ((g.includeNums) ? 0 : 1); i < h.length; i++) {
                     if (e[h[i]] > 0) {
                        j = true;
                        $('.' + h[i], $letters).slice(0, 1).click();
                        break
                     }
                  }
               }
            }
         }

         function setLetterCountTop() {
            $letterCount.css({
               top: $('.a', $letters).slice(0, 1).offset({
                  margin: false,
                  border: true
               }).top - $letterCount.outerHeight({
                  margin: true
               })
            })
         }

         function addClasses() {
            var a, firstChar, firstWord, spl, $this, hasPrefixes = (g.prefixes.length > 0);
            $($list).children().each(function () {
               $this = $(this), firstChar = '', a = $.trim($this.text()).toLowerCase();
               if (a != '') {
                  if (hasPrefixes) {
                     spl = a.split(' ');
                     if ((spl.length > 1) && ($.inArray(spl[0], g.prefixes) > -1)) {
                        firstChar = spl[1].charAt(0);
                        addLetterClass(firstChar, $this, true)
                     }
                  }
                  firstChar = a.charAt(0);
                  addLetterClass(firstChar, $this)
               }
            })
         }

         function addLetterClass(a, b, c) {
            if (/\W/.test(a)) a = '-';
            if (!isNaN(a)) a = '_';
            b.addClass('ln-' + a);
            if (e[a] == undefined) e[a] = 0;
            e[a]++;
            if (!c) allCount++
         }

         function addDisabledClass() {
            for (var i = 0; i < h.length; i++) {
               if (e[h[i]] == undefined) $('.' + h[i], $letters).addClass('ln-disabled')
            }
         }

         function addNoMatchLI() {
            $list.append('<li class="ln-no-match" style="display:none">' + g.noMatchText + '</li>')
         }

         function getLetterCount(a) {
            if ($(a).hasClass('all')) return allCount;
            else {
               var b = e[$(a).attr('class').split(' ')[0]];
               return (b != undefined) ? b : 0
            }
         }

         function bindHandlers() {
            if (g.showCounts) {
               d.mouseover(function () {
                  setLetterCountTop()
               })
            }
            if (g.showCounts) {
               $('a', $letters).mouseover(function () {
                  var a = $(this).position().left;
                  var b = ($(this).outerWidth({
                     margin: true
                  }) - 1) + 'px';
                  var c = getLetterCount(this);
                  $letterCount.css({
                     left: a,
                     width: b
                  }).text(c).show()
               });
               $('a', $letters).mouseout(function () {
                  $letterCount.hide()
               })
            }
            $('a', $letters).click(function () {
               $('a.ln-selected', $letters).removeClass('ln-selected');
               var a = $(this).attr('class').split(' ')[0];
               if (a == 'all') {
                  $list.children().show();
                  $list.children('.ln-no-match').hide();
                  isAll = true
               } else {
                  if (isAll) {
                     $list.children().hide();
                     isAll = false
                  } else if (prevLetter != '') $list.children('.ln-' + prevLetter).hide();
                  var b = getLetterCount(this);
                  if (b > 0) {
                     $list.children('.ln-no-match').hide();
                     $list.children('.ln-' + a).show()
                  } else $list.children('.ln-no-match').show();
                  prevLetter = a
               }
               if ($.cookie && (g.cookieName != null)) $.cookie(g.cookieName, a);
               $(this).addClass('ln-selected');
               $(this).blur();
               if (!j && (g.onClick != null)) g.onClick(a);
               else j = false;
               return false
            })
         }

         function createLettersHtml() {
            var a = [];
            for (var i = 1; i < h.length; i++) {
               if (a.length == 0) a.push('<a class="all" href="#">ALL</a><a class="_" href="#">0-9</a>');
               a.push('<a class="' + h[i] + '" href="#">' + ((h[i] == '-') ? '...' : h[i].toUpperCase()) + '</a>')
            }
            // ttgiang added this for exporting option
            a.push('<a class="export" href="/">Export</a>');
            return '<div class="ln-letters">' + a.join('') + '</div>' + ((g.showCounts) ? '<div class="ln-letter-count" style="display:none; position:absolute; top:0; left:0; width:20px;">0</div>' : '')
         }
         init()
      })
   };
   $.fn.listnav.defaults = {
      initLetter: '',
      includeAll: true,
      incudeOther: false,
      includeNums: true,
      flagDisabled: true,
      noMatchText: 'No matching entries',
      showCounts: true,
      cookieName: null,
      onClick: null,
      prefixes: []
   }
})(jQuery);

