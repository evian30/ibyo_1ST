// 좌측 패널 (region : west ) 클래스
WestArea = function() {
 WestArea.superclass.constructor.call(this, {
  region : 'west',
  title : 'WEST',
  collapsible : true,
  collapsed : false,
  width : 300,
  minSize : 100,
  split : true,
  layout : 'fit',
  margins : '5 0 5 5',
  cmargins : '5 5 5 5',
  html : '좌측'
 })
};
Ext.extend(WestArea, Ext.Panel, {});

// 우측 패널 (region: east) 클래스
EastArea = function() {
 EastArea.superclass.constructor.call(this, {
  region : 'east',
  title : 'EAST',
  collapsible : true,
  collapsed : false,
  width : 300,
  minSize : 100,
  split : true,
  layout : 'fit',
  margins : '5 5 5 0',
  cmargins : '5 5 5 5',
  html : '우측'
 })
};
Ext.extend(EastArea, Ext.Panel, {});

// 중앙 컨텐츠 패널 (region : center) 클래스
CenterArea = function() {
 CenterArea.superclass.constructor.call(this, {
  region : 'center',
  title : 'CENTER',
  layout : 'fit',
  margins : '5 0 5 0',
  html : '<div id="_CONTENTS_AREA_">컨텐츠 영역입니다.</div>'
 })
};
Ext.extend(CenterArea, Ext.Panel, {});

// 메인 클래스
BasicLayoutClass = function() {
 return {
  init : function() {
   Ext.QuickTips.init();
   this.viewport = new Ext.Viewport( {
    layout : 'border',
    items : [this.WestPanel = new WestArea(),
      this.EastPanel = new EastArea(),
      this.CenterPanel = new CenterArea()]
   });

   this.viewport.doLayout();
   this.viewport.syncSize();
  }
 }
}();
Ext.EventManager.onDocumentReady(BasicLayoutClass.init, BasicLayoutClass, true);