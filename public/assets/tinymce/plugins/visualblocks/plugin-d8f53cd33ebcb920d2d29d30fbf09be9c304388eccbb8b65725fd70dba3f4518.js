!function(){var e={},o=function(o){for(var n=e[o],i=n.deps,s=n.defn,l=i.length,a=new Array(l),c=0;c<l;++c)a[c]=t(i[c]);var u=s.apply(null,a);if(void 0===u)throw"module ["+o+"] returned undefined";n.instance=u},n=function(o,n,t){if("string"!=typeof o)throw"module id must be a string";if(void 0===n)throw"no dependencies for "+o;if(void 0===t)throw"no definition function for "+o;e[o]={deps:n,defn:t,instance:void 0}},t=function(n){var t=e[n];if(void 0===t)throw"module ["+n+"] was undefined";return void 0===t.instance&&o(n),t.instance},i=function(e,o){for(var n=e.length,i=new Array(n),s=0;s<n;++s)i.push(t(e[s]));o.apply(null,o)};({}).bolt={module:{api:{define:n,require:i,demand:t}}};var s=n;(function(e,o){s(e,[],function(){return o})})("2",tinymce.util.Tools.resolve),s("1",["2"],function(e){return e("tinymce.PluginManager")}),s("0",["1"],function(e){return e.add("visualblocks",function(e,o){function n(){var o=this;o.active(s),e.on("VisualBlocks",function(){o.active(e.dom.hasClass(e.getBody(),"mce-visualblocks"))})}var t,i,s;window.NodeList&&(e.addCommand("mceVisualBlocks",function(){var n,l=e.dom;t||(t=l.uniqueId(),n=l.create("link",{id:t,rel:"stylesheet",href:o+"/css/visualblocks.css"}),e.getDoc().getElementsByTagName("head")[0].appendChild(n)),e.on("PreviewFormats AfterPreviewFormats",function(o){s&&l.toggleClass(e.getBody(),"mce-visualblocks","afterpreviewformats"==o.type)}),l.toggleClass(e.getBody(),"mce-visualblocks"),s=e.dom.hasClass(e.getBody(),"mce-visualblocks"),i&&i.active(l.hasClass(e.getBody(),"mce-visualblocks")),e.fire("VisualBlocks")}),e.addButton("visualblocks",{title:"Show blocks",cmd:"mceVisualBlocks",onPostRender:n}),e.addMenuItem("visualblocks",{text:"Show blocks",cmd:"mceVisualBlocks",onPostRender:n,selectable:!0,context:"view",prependToContext:!0}),e.on("init",function(){e.settings.visualblocks_default_state&&e.execCommand("mceVisualBlocks",!1,null,{skip_focus:!0})}),e.on("remove",function(){e.dom.removeClass(e.getBody(),"mce-visualblocks")}))}),function(){}}),t("0")()}();