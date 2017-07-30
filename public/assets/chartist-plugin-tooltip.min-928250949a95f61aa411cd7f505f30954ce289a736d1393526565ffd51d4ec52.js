!function(t,e){"function"==typeof define&&define.amd?define(["chartist"],function(n){return t.returnExportsGlobal=e(n)}):"object"==typeof exports?module.exports=e(require("chartist")):t["Chartist.plugins.tooltips"]=e(Chartist)}(this,function(t){return function(t,e,n){"use strict";function o(t){a(t,"tooltip-show")||(t.className=t.className+" tooltip-show")}function i(t){var e=new RegExp("tooltip-show\\s*","gi");t.className=t.className.replace(e,"").trim()}function a(t,e){return(" "+t.getAttribute("class")+" ").indexOf(" "+e+" ")>-1}function r(t,e){do{t=t.nextSibling}while(t&&!a(t,e));return t}function s(t){return t.innerText||t.textContent}var c={currency:undefined,currencyFormatCallback:undefined,tooltipOffset:{x:0,y:-20},anchorToPoint:!1,appendToBody:!1,"class":undefined,pointClass:"ct-point"};n.plugins=n.plugins||{},n.plugins.tooltip=function(l){return l=n.extend({},c,l),function(c){function p(t,e,n){d.addEventListener(t,function(t){e&&!a(t.target,e)||n(t)})}function f(e){m=m||g.offsetHeight,h=h||g.offsetWidth;var n,o,i=-h/2+l.tooltipOffset.x,a=-m+l.tooltipOffset.y;if(l.appendToBody)g.style.top=e.pageY+a+"px",g.style.left=e.pageX+i+"px";else{var r=d.getBoundingClientRect(),s=e.pageX-r.left-t.pageXOffset,c=e.pageY-r.top-t.pageYOffset;!0===l.anchorToPoint&&e.target.x2&&e.target.y2&&(n=parseInt(e.target.x2.baseVal.value),o=parseInt(e.target.y2.baseVal.value)),g.style.top=(o||c)+a+"px",g.style.left=(n||s)+i+"px"}}var u=l.pointClass;c instanceof n.Bar?u="ct-bar":c instanceof n.Pie&&(u=c.options.donut?"ct-slice-donut":"ct-slice-pie");var d=c.container,g=d.querySelector(".chartist-tooltip");g||(g=e.createElement("div"),g.className=l["class"]?"chartist-tooltip "+l["class"]:"chartist-tooltip",l.appendToBody?e.body.appendChild(g):d.appendChild(g));var m=g.offsetHeight,h=g.offsetWidth;i(g),p("mouseover",u,function(t){var i=t.target,a="",p=c instanceof n.Pie?i:i.parentNode,u=p?i.parentNode.getAttribute("ct:meta")||i.parentNode.getAttribute("ct:series-name"):"",d=i.getAttribute("ct:meta")||u||"",y=!!d,x=i.getAttribute("ct:value");if(l.transformTooltipTextFnc&&"function"==typeof l.transformTooltipTextFnc&&(x=l.transformTooltipTextFnc(x)),l.tooltipFnc&&"function"==typeof l.tooltipFnc)a=l.tooltipFnc(d,x);else{if(l.metaIsHTML){var v=e.createElement("textarea");v.innerHTML=d,d=v.value}if(d='<span class="chartist-tooltip-meta">'+d+"</span>",y)a+=d+"<br>";else if(c instanceof n.Pie){var b=r(i,"ct-label");b&&(a+=s(b)+"<br>")}x&&(l.currency&&(x=l.currencyFormatCallback!=undefined?l.currencyFormatCallback(x,l):l.currency+x.replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g,"$1,")),x='<span class="chartist-tooltip-value">'+x+"</span>",a+=x)}a&&(g.innerHTML=a,f(t),o(g),m=g.offsetHeight,h=g.offsetWidth)}),p("mouseout",u,function(){i(g)}),p("mousemove",null,function(t){!1===l.anchorToPoint&&f(t)})}}}(window,document,t),t.plugins.tooltips});