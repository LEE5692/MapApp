<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>

<head>
	<title>지도서비스</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.15.1/css/ol.css" type="text/css">
	
	<style type="text/css">
	body{
		margin : 0 0 0 0;
	}
	#title{
		position:absolute;
		width:350px;
		height:80px;
		background:skyblue;
		text-align:center;
		color:white;
	}
	#submenu{
		position:absolute;
		top:80px;
		width:350px;
		height:calc(100% - 80px);
		background:steelblue;
	}
	#maparea{
		position:absolute;
		left:350px;
		top:0px;
		width:calc(100% - 350px);
		height:100%;
		background:grey;
	}
</style>
 <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.15.1/build/ol.js"></script>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>

<!-- 서비스제목 -->
<div id="title">
<h1> 위치정보서비스 </h1>
</div>
<!--  메뉴상세 -->
<div id="submenu">
	<button onclick="getAttData()">관광 명소 정보조회</button>
</div>
<!-- 지도 영역 -->
<div id="maparea">
</div>
 <script type="text/javascript">
      var map = new ol.Map({
        target: 'maparea',
        layers: [
          new ol.layer.Tile({
            source: new ol.source.OSM()
          })
        ],
        view: new ol.View({
          projection: 'EPSG:4326',
          center: [127,36],
          zoom: 6
        })
      });
      function getAttData(){
    	  $.get('./getAttractionData.do', addAttFeatures);
    	  
      }
      function addAttFeatures(data){
    	  var attData = data.rst;
    	  
    	  const iconStyle = new ol.style.Style({
        	  image: new ol.style.Icon({
        	    anchor: [0.5, 46],
        	    anchorXUnits: 'fraction',
        	    anchorYUnits: 'pixels',
        	    src: 'https://openlayers.org/en/latest/examples/data/icon.png',
        	  }),
        	});
    	let vectorSource = new ol.source.Vector({});
    	
    	attData.forEach(function(data, idx){
    		let iconFeature = new ol.Feature({
    			geometry : new ol.geom.Point([data.lng, data.lat]),
    			name: data.name
    		});
    
      		iconFeature.setStyle(iconStyle);
    		vectorSource.addFeature(iconFeature);
      })
      
      let vectorLayer = new ol.layer.Vector({
    	  source : vectorSource
      });
      
      map.addLayer(vectorLayer);
      map.getView().fit(vectorSource.getExtent(), map.getSize())
     }
     
    </script>
</body>
</html>

