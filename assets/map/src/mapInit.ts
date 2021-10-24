import * as mapboxgl from "mapbox-gl";
import { IArea } from ".";
import { getMarkers } from "./parse";

export function loadPointsToMap(map:mapboxgl.Map, inputs:IArea[], is_polygon=false, with_circles=true) {
    
    var active = new Set;

    try {
        active = new Set(localStorage.getItem("activePoint").split(",").map((e) => parseInt(e)));
    } catch{}

    let dataMarkers = getMarkers(inputs);
    let markers = dataMarkers.markers
    let markersCoverage = dataMarkers.markersCoverage
    let outlines = dataMarkers.outlines
    console.log(outlines, markers, markersCoverage);
    
    
    for (var i = 0; i < markersCoverage.length; ++i) {
        console.log(markers[i]);
        if (active.has(parseInt(markers[i].id))) {
            outlines[i].properties = markersCoverage[i].properties;
            outlines[i].properties.active = true;
            markers[i].properties = {img: "active-marker"};
        }
        else {
            markers[i].properties = {img:  "custom-marker"};
            outlines[i].properties = {color: "#C4C4C400", active: false};
        }
        
        outlines[i].geometry.coordinates.push(outlines[i].geometry.coordinates[0]);
    }
    console.log(outlines);
    if (localStorage.getItem("blackTheme") != "true"){
        map.addSource('markersCoverage', {
            'type': 'geojson',
            'data': {
                'type': 'FeatureCollection',
                'features': markersCoverage}
        })
        if (with_circles){
            map.addLayer(
                {
                    'id': 'markersCoverage',
                    'type': 'fill',
                    'source': 'markersCoverage',
                    'layout': {},
                    "minzoom" : 8,
                    'paint': {
                        'fill-color': ["get", "color"],
                        'fill-opacity': is_polygon ? 1 : 0.25
                    }
                }
            )
        }
    }
    //outlines.map()
    map.addLayer({
        "id": "outlines",
        "type": "line",
        "source": {
            "type": "geojson",
            "data": {
                
                    'type': 'FeatureCollection',
                    'features': outlines
                }
        },
        "minzoom" : 8,
        
        "paint": {
            "line-color": ["get", "color"],
            "line-width": 3,
            "line-opacity": ["case", ["boolean", ["get", "active"], true], 1, 0]
        }
    });
    map.addSource('points', {
        'type': 'geojson',
        'data': {
            'type': 'FeatureCollection',
            'features': markers
        }
    });
    map.addLayer({
        'id': 'points',
        'type': 'symbol',
        'source': 'points',
        'layout': {
            'icon-image': ["get", "img"],
            // get the title name from the source's "title" property
            'text-field': ['get', 'title'],
            'text-font': [
                'Open Sans Semibold',
                'Arial Unicode MS Bold'
            ],
            'text-offset': [0, 1.25],
            'text-anchor': 'top'
        }
    });
}